# struct_definer.gemspec
require_relative "lib/struct_definer/version"

Gem::Specification.new do |spec|
  spec.name        = "struct_definer"
  spec.version     = StructDefiner::VERSION
  spec.authors     = ["Jayaprakash Joshi"] # CHANGE THIS
  spec.email       = ["jaiprince17@gmail.com"] # CHANGE THIS

  spec.summary     = "A simple DSL to define structured messages."
  spec.description = "Allows dynamic definition of classes with typed fields, similar to Protobuf messages but simpler."
  spec.homepage    = "https://github.com/y2kstack/struct_definer" # CHANGE THIS
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.5.0"


  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/y2kstack" # CHANGE THIS

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/y2kstack/struct_definer" # CHANGE THIS

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.end_with?(".gem") || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end