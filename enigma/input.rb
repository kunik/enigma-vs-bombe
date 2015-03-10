require_relative 'wiring'

module Enigma
  class Input < Wiring
    def initialize
      wires = (0..Letters.count - 1)
      @mapping = Hash[Letters.zip wires]
    end
  end
end