lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rusty_lmdb/version"

Gem::Specification.new do |spec|
  spec.name          = "rusty_lmdb"
  spec.version       = RustyLMDB::VERSION
  spec.authors       = ["Alastair Pharo"]
  spec.email         = ["me@asph.dev"]

  spec.summary       = 'An interface to LMDB implemented in Rutie/Rust'
  spec.homepage      = 'https://github.com/asppsa/rusty_lmdb'
  spec.license       = 'Apache-2.0'

  spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions << 'ext/Rakefile'

  spec.add_runtime_dependency "rutie", "~> 0.0.4"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency 'irb', '~> 1.0.0'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rubocop', '~> 0.74.0'
end
