require_relative 'wiring'

module Enigma
  class Output < Wiring
    def initialize(input)
      @mapping = input.mapping.invert
    end
  end
end