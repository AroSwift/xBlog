# -*- encoding: utf-8 -*-
# stub: show_me_the_cookies 3.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "show_me_the_cookies"
  s.version = "3.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nicholas Rutherford"]
  s.date = "2015-07-10"
  s.description = "Cookie manipulation for Capybara drivers -- viewing, deleting, ..."
  s.email = ["nick.rutherford@gmail.com"]
  s.homepage = "https://github.com/nruth/show_me_the_cookies"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Cookie manipulation for Capybara drivers"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capybara>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<poltergeist>, [">= 0"])
      s.add_development_dependency(%q<selenium-webdriver>, [">= 0"])
      s.add_development_dependency(%q<chromedriver-helper>, [">= 0"])
      s.add_development_dependency(%q<capybara-webkit>, [">= 0"])
    else
      s.add_dependency(%q<capybara>, ["~> 2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<poltergeist>, [">= 0"])
      s.add_dependency(%q<selenium-webdriver>, [">= 0"])
      s.add_dependency(%q<chromedriver-helper>, [">= 0"])
      s.add_dependency(%q<capybara-webkit>, [">= 0"])
    end
  else
    s.add_dependency(%q<capybara>, ["~> 2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<poltergeist>, [">= 0"])
    s.add_dependency(%q<selenium-webdriver>, [">= 0"])
    s.add_dependency(%q<chromedriver-helper>, [">= 0"])
    s.add_dependency(%q<capybara-webkit>, [">= 0"])
  end
end
