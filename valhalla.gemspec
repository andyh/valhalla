# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{valhalla}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Henson"]
  s.date = %q{2009-02-07}
  s.default_executable = %q{typo3}
  s.description = %q{A collection of tasks for automating TYPO3}
  s.email = %q{andy@foxsoft.co.uk}
  s.executables = ["typo3"]
  s.files = ["README.textile", "VERSION.yml", "bin/typo3", "lib/typo3", "lib/typo3/installer.rb", "lib/valhalla.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/andyh/valhalla}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<erubis>, [">= 2.6.2"])
      s.add_runtime_dependency(%q<rake>, [">= 0.8.3"])
      s.add_runtime_dependency(%q<mysql>, [">= 2.7"])
      s.add_runtime_dependency(%q<wycats-thor>, [">= 0.9.8"])
    else
      s.add_dependency(%q<erubis>, [">= 2.6.2"])
      s.add_dependency(%q<rake>, [">= 0.8.3"])
      s.add_dependency(%q<mysql>, [">= 2.7"])
      s.add_dependency(%q<wycats-thor>, [">= 0.9.8"])
    end
  else
    s.add_dependency(%q<erubis>, [">= 2.6.2"])
    s.add_dependency(%q<rake>, [">= 0.8.3"])
    s.add_dependency(%q<mysql>, [">= 2.7"])
    s.add_dependency(%q<wycats-thor>, [">= 0.9.8"])
  end
end
