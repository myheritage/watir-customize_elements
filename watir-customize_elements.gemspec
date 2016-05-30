Gem::Specification.new do |s|
  s.name = "watir-customize_elements"
  s.platform = Gem::Platform::RUBY
  s.version = '0.0.1'
  s.authors = ["Yehuda Miller, Shani Raby, Matan Goren, Ronnie Harpaz"]
  s.homepage    = 'https://github.com/myheritage/watir-customize_elements'
  s.license = 'Apache-2.0'
  s.summary = 'Gem for adding custom elements to Watir-webdriver and page-object gem'
  s.description = 'Automatically instantiates custom HTML tag names into watir-webdriver and\or page-object gem.'

  s.files = ["lib/watir-customize_elements.rb", "LICENSE.txt", "README.md", "example_custom_elements.yml"]
  s.require_paths = ["lib"]

  s.add_dependency 'watir-webdriver', '>= 0.6.11'
  s.add_dependency 'page-object'
end
