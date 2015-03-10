require_relative 'rotor'
require_relative 'concerns/configurable'

module Enigma
  class Rotors
    extend Configurable
    default_config { (0..2).map { Rotor.default_config } }
  end
end