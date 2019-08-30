#[macro_use] extern crate rutie;
#[macro_use] extern crate lazy_static;

use rkv::{Manager, Rkv, SingleStore, Value, StoreOptions};
use std::fs;
use tempfile::Builder;

use std::ops::{Deref, DerefMut};
use rutie::{AnyObject, Class, Module, Array, Integer, Boolean, AnyException, GC, NilClass, Object, VM};
use rutie::types::Value;

pub struct HashableObject {
  value: Value,
  hash: i64
}

impl HashableObject {
  fn get_hash<T: Object>(object: &T) -> i64 {
    object.send("hash", &[])
      .try_convert_to::<Integer>()
      .map_err(|e| VM::raise_ex(e))
      .unwrap()
      .to_i64()
  }
}

impl<T: Object> From<&T> for HashableObject {
  fn from(object: &T) -> Self {
    Self {
      hash: Self::get_hash(object),
      value: object.value()
    }
  }
}

impl From<Value> for HashableObject {
  fn from(value: Value) -> Self {
    Self::from(&AnyObject::from(value))
  }
}

impl Object for HashableObject {
  #[inline]
  fn value(&self) -> Value {
    self.value
  }
}

impl PartialEq for HashableObject {
  fn eq(&self, other: &Self) -> bool {
    self.is_eql(other)
  }
}

impl Eq for HashableObject {}

impl std::hash::Hash for HashableObject {
  // Use the oject's hash if it has one; otherwise, fall back to object ID
  fn hash<H: std::hash::Hasher>(&self, state: &mut H) {
    self.hash.hash(state);
  }
}
