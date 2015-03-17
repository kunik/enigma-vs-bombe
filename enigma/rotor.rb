require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Rotor < Wiring
    def initialize(mapping)
      @original_mapping = mapping
      reset!
    end

    def convert_back(signal)
      mapping.index(signal)
    end

    alias :>> :convert_back

    def size
      mapping.length
    end

    def rotate!
      mapping << mapping.shift
    end

    def reset!
      @mapping = @original_mapping.dup
    end

    class << self
      def default_config
        (0..Letters.count - 1).to_a.rotate(::Random.rand(25))
      end
    end
  end
end