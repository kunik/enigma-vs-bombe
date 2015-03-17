require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Reflector < Wiring
    default_config { Hash[*Letters.range.to_a.shuffle] }

    def initialize(mapping)
      @mapping = mapping
      @mapping.merge! @mapping.invert
    end
  end
end