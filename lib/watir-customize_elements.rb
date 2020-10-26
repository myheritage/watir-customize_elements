require 'watir'
require 'page-object'
require 'yaml'

=begin
Copyright 2016 MyHeritage, Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
=end

module WatirCustomizeElements

  config_file = ENV['CUSTOM_ELEMENTS_CONFIG_PATH']
  @config = YAML::load_file(config_file) unless config_file.nil?

  def self.custom_elements
    custom_elements = @config['elements'] unless @config.nil?
  end

  def self.modules
    modules = @config['modules'] unless @config.nil?
  end

end


unless WatirCustomizeElements.custom_elements.nil?
  if WatirCustomizeElements.modules['watir']
    # Extending Watir module
    module Watir
      # Extending Container module
      module Container
        # Do the following for each custom element to add
        WatirCustomizeElements.custom_elements.each do |key, values|
          # Defines the element in Watir as a method
          define_method(key.to_sym) { |*args| eval(values['element_class']).new(self, extract_selector(args).merge(:tag_name => key.gsub('_', '-'))) }

          # Defines a collection of elements in Watir as a method
          define_method(values['element_collection']) { |*args| eval("#{values['element_class']}Collection").new(self, extract_selector(args).merge(:tag_name => key.gsub('_', '-'))) }

          # Instantiate the classes for a single element and the collection of elements
          Container.const_set(values['element_class'], Class.new(Element))
          Container.const_set("#{values['element_class']}Collection", Class.new(ElementCollection) do
            define_method('element_class') { eval(values['element_class']) }
          end)
        end
      end
    end

  end

  if WatirCustomizeElements.modules['page_object']
    # Adding each custom element to PageObject gem
    WatirCustomizeElements.custom_elements.each do |key, values|
      # Interacting with the element
      Object.const_set(values['element_class'], Class.new(eval("PageObject::Elements::#{values['element_type']}")))

      # Registering the class with the PageObject gem.
      # register_widget accepts a tag which is used as the accessor (ex: mh_button), the class which is added to
      # the Elements module (ex: MHButton), and a html element tag which is used as the html element (ex: mh_button).
      PageObject.register_widget key.to_sym, eval(values['element_class']), key.to_sym
    end
  end

end
