# -*- encoding: utf-8 -*-
# stub: haml-contrib 1.0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "haml-contrib"
  s.version = "1.0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Norman Clarke"]
  s.date = "2013-05-28"
  s.description = "Addons for the Ruby implementation of the Haml template language."
  s.email = ["norman@njclarke.com"]
  s.homepage = "http://haml.info/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Addons to Haml"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 3.2.0.alpha.13"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 3.2.0.alpha.13"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, [">= 3.2.0.alpha.13"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
