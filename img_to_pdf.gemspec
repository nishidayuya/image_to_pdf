require "pathname"

require_relative "lib/img_to_pdf/version"

Gem::Specification.new do |spec|
  spec.name          = "img_to_pdf"
  spec.version       = ImgToPdf::VERSION
  spec.authors       = ["Yuya.Nishida."]
  spec.email         = ["yuya@j96.org"]

  readme_path = Pathname(__dir__) / "README.md"
  if readme_path.exist? # cannot read on Dependabot
    spec.summary = readme_path.each_line(chomp: true).
                     lazy.grep_v(/\A\s*\z|\A\#/).first
    spec.description = spec.summary
  else
    warn("No README.md, so cannot set gem summary and description.")
  end

  spec.homepage      = "https://github.com/nishidayuya/#{spec.name}"
  spec.license       = "X11"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mini_magick"
  spec.add_runtime_dependency "prawn"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
  # for broken test-reporter:
  # https://github.com/codeclimate/test-reporter/issues/418
  spec.add_development_dependency "simplecov-lcov"
  spec.add_development_dependency "test-unit"
end
