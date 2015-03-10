require_relative 'rotor'

module Enigma
  class RotorsBlock
    attr_reader :rotors, :reflector
    def initialize(rotors, reflector)
      @rotors = rotors
      @reflector = reflector
      reset!
    end

    def reset!
      @step = 0
      @rotors.each &:reset!
    end

    def step!
      @step += 1
      rotors.each_with_index {|rotor, i| rotor.rotate! if (@step % rotor.size ** i) == 0}
    end

    def <<(signal)
      step!
      rotors.each {|rotor| signal = rotor << signal}
      signal = reflector << signal
      rotors.reverse.each {|rotor| signal = rotor >> signal }
      signal
    end
  end
end