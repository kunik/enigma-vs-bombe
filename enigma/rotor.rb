require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Rotor < Wiring
    default_config { Letters.range.to_a.shuffle }
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
  end
end