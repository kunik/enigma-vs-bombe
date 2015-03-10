require_relative 'rotor'

module Enigma
  class Rotors
    class << self
      def default_config
        (0..2).map { Rotor.default_config }
      end
    end
  end
end