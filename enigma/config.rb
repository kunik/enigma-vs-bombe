require 'yaml'
require 'pathname'

require_relative 'plugboard'
require_relative 'rotor'
require_relative 'reflector'

module Enigma
  class Config < BasicObject
    attr_reader :path, :root

    def initialize(path='config.yml')
      @root = ::Pathname.new ::File.expand_path('../..', __FILE__)
      @path = @root.join path
    end

    def exists?
      path.exist?
    end

    def loaded?
      @loaded ||= false
    end

    def reset!
      destroy! if exists?
    end

    def method_missing(method_name, *args)
      if method_name =~ /^(\w+)=$/
        return set_config($1, args[0])
      else
        element = method_name.to_s
        element_path = root.join('enigma', "#{element}.rb")
        if element_path.exist?
          ::Kernel.require element_path.to_s
          return get_config element
        end
      end

      super
    end

    protected
    def get_config(element)
      @config ||= {}
      load! if exists? && !loaded?
      set_config(element, Helpers._get_element_class(element).default_config) unless @config[element]
      @config[element]
    end

    def set_config(element, value)
      @config ||= {}
      @config[element] = value
      save!
    end

    def save!
      ::File.open(path, 'w') do |f|
        f.write @config.to_yaml
      end
    end

    def load!
      @config = ::YAML::load_file path
      @loaded = true
    end

    def destroy!
      path.delete if exists?
      @loaded = false
    end

    module Helpers
      module_function
      def _get_element_class(name)
        ::Kernel.const_get "::Enigma::#{_camelize(name)}"
      end

      def _camelize(term, uppercase_first_letter = true)
        string = term.to_s
        if uppercase_first_letter
          string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        else
          string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
        end
        string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
        string.gsub!(/\//, '::')
        string
      end
    end
  end
end