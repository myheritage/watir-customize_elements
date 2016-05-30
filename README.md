# watir-customize_elements
The purpose of this gem is to enable Watir-Webdriver and page-object gem to work with custom, non-standard HTML element tag names.

While Watir-Webdriver and the page-object gem do not support non-standard HTML tags, we encountered many cases in our testing when we needed to use such elements.
Although it's possible to register custom elements with PageObject via [widgets](https://github.com/cheezy/page-object/wiki/Widgets-%28registering-custom-elements-with-PageObject%29), and to add support for it in Watir, the process of doing so for each custom element got tedious.
That's why we created this gem. It automatically instantiates custom HTML tag names into watir-webdriver and/or page-object gem from a few lines in a simple yml file.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'watir-customize_elements'
```

And then execute:
```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install watir-customize_elements
```

## Usage 
- Create a yml file (call it whatever you like), and include the name and path as an env argument named `CUSTOM_ELEMENTS_CONFIG_PATH`. See explanation at the end of this section
- Require watir-customize_elements **after** requiring watir-webdriver and/or page-object.
- If you don't want to pass `ENV[CUSTOM_ELEMENTS_CONFIG_PATH]` from the command line, set it **before** requiring watir-customize_elements
```ruby
require 'watir-webdriver'
require 'page-object'
ENV['CUSTOM_ELEMENTS_CONFIG_PATH'] = 'path\to\custom_elements_file.yml'
require 'watir-customize_elements'
```
## yml file
The yml file should include two parts: modules and elements

```
modules:
  watir: true
  page_object: true
elements:
  element_name:
    element_collection: element_names
    element_class: ElementName
    element_type: CheckBox
  mh_button:
    element_collection: mh_buttons
    element_class: MHButton
    element_type: Button
```	
##### Modules
Determines which gem to interact with. Configure according to your setup.
##### Elements section explained:
- element_name - This is the exact name of the tag type, with underscores instead of dashes
- element_collection - This is the name of the element name, but pluralized. element-name would be element_name
- element_class - This is the element name in class form. mh-checkbox would be MHCheckBox.
- element_type- This is the PageObject element type (found here: http://bit.ly/1TNEtal). This will give your custom
      element the same type of attribute as its native HTML element type (ex: mh-checkbox with a type of CheckBox is
      treated by PageObject as a true HTML checkbox). If there isn't a matching type, choose Element.

You can find an example of a complete yml file here (add link to example_custom_elements.yml).
