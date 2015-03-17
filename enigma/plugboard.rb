require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Plugboard < Wiring
    default_config { Hash[*Letters.shuffle.take(20)] }

    def initialize(pairs)
      @mapping = pairs.dup
      @mapping.default_proc = proc { |hash, key| key }
      @mapping.merge! @mapping.invert
    end
  end
end