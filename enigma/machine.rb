require_relative 'letters'
require_relative 'input'
require_relative 'output'
require_relative 'plugboard'
require_relative 'rotor'
require_relative 'reflector'
require_relative 'rotors_block'

module Enigma
  class Machine
    attr_reader :input, :output, :plugboard, :rotors, :reflector, :rotors_block
    def initialize(config)
      Letters.configure!(config.letters)

      @reflector    = Reflector.new config.reflector
      @rotors       = config.rotors.map {|conf| Rotor.new conf }
      @plugboard    = Plugboard.new config.plugboard

      @rotors_block = RotorsBlock.new(@rotors, @reflector)
      @input        = Input.new
      @output       = Output.new(@input)
    end

    def process(string)
      string.chars.map{ |char| plugboard << (output << (rotors_block << (input << (plugboard << char)))) }.join
    end

    def reset!
      rotors_block.reset!
    end
  end
end