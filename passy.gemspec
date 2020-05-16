require_relative 'lib/passy/version'

Gem::Specification.new do |spec|
  spec.name          = "passy"
  spec.version       = Passy::VERSION
  spec.authors       = ["Joel AZEMAR"]
  spec.email         = ["joel.azemar@gmail.com"]

  spec.summary       = %q{Human password encryption}
  spec.description   = %q{Apply simple rules to encrypt plain text}
  spec.homepage      = "http://mygemserver.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["encrypt"]
  spec.require_paths = ["lib"]

  spec.add_dependency 'zeitwerk'
  spec.add_dependency 'clipboard'
  spec.add_dependency 'passgen'
end
