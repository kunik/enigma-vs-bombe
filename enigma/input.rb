require_relative 'wiring'

module Enigma
  class Input < Wiring
    def initialize
      @mapping = Hash[Letters.zip Letters.range]
    end
  end
end