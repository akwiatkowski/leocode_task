# frozen_string_literal: true

require_relative 'lib/leocode/version'

Gem::Specification.new do |spec|
  spec.name          = "leocode"
  spec.version       = Leocode::VERSION
  spec.authors       = ["Aleksander Kwiatkowski"]
  spec.email         = ["bobikx@poczta.fm"]

  spec.summary       = 'Checkout system'
  spec.description   = 'Checkout system'
  spec.homepage      = "https://github.com/akwiatkowski"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/akwiatkowski/leocode"
  spec.metadata["changelog_uri"] = "https://github.com/akwiatkowski/leocode/changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
