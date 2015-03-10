Letters = ('A'..'Z')

class Wiring
  attr_reader :mapping

  def convert(signal)
    mapping[signal]
  end

  alias :<< :convert
end

class Input < Wiring
  def initialize(letters)
    wires = (0..letters.count - 1)
    @mapping = Hash[letters.zip wires]
  end
end


class Output < Wiring
  def initialize(input)
    @mapping = input.mapping.invert
  end
end


class Plugboard < Wiring
  def initialize(pairs)
    @mapping = pairs.dup
    @mapping.default_proc = proc { |hash, key| key }
    @mapping.merge! @mapping.invert
  end
end


class Rotor < Wiring
  def initialize
    @original_mapping = (0..Letters.count - 1).to_a.shuffle
    reset!
  end

  def convert_back(signal)
    mapping.index(signal)
  end

  alias :>> :convert_back

  def size
    mapping.length
  end

  def rotate!
    mapping << mapping.shift
  end

  def reset!
    @mapping = @original_mapping.dup
  end
end

class Reflector < Wiring
  def initialize
    @mapping = Hash[*(0..Letters.count - 1).to_a.shuffle]
    @mapping.merge! @mapping.invert
  end
end

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


class Enigma
  attr_reader :input, :output, :plugboard, :rotors_block
  def initialize
    @rotors_block = RotorsBlock.new((0..2).map{Rotor.new}, Reflector.new)
    @plugboard    = Plugboard.new(Hash[*Letters.to_a.shuffle.first(20)])
    @input        = Input.new(Letters)
    @output       = Output.new(@input)
  end

  def process(string)
    reset!
    string.chars.map{ |char| plugboard << (output << (rotors_block << (input << (plugboard << char)))) }.join
  end

  def reset!
    rotors_block.reset!
  end
end

