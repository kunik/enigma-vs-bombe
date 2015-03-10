require_relative 'rotor'

module Enigma
  class Rotors
    class << self
      def range
        (0..2)
      end

      def default_config
        range.map { Rotor.default_config }
      end
    end
  end
end