Gem::Specification.new do |s|
  s.name = %q{settingslogic}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Johnson of Binary Logic"]
  s.date = %q{2008-11-02}
  s.description = %q{Simple and straightforward application wide settings}
  s.email = %q{bjohnson@binarylogic.com}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "lib/settingslogic/config.rb", "lib/settingslogic/settings.rb", "lib/settingslogic/version.rb", "lib/settingslogic.rb", "README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "init.rb", "lib/settingslogic/config.rb", "lib/settingslogic/settings.rb", "lib/settingslogic/version.rb", "lib/settingslogic.rb", "Manifest", "MIT-LICENSE", "Rakefile", "README.rdoc", "test/application.yml", "test/application2.yml", "test/test_config.rb", "test/test_helper.rb", "test/test_setting.rb", "settingslogic.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/binarylogic/settingslogic}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Settingslogic", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{settingslogic}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Simple and straightforward application wide settings}
  s.test_files = ["test/test_config.rb", "test/test_helper.rb", "test/test_setting.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
