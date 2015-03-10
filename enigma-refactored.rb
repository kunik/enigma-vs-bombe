Letters = ('A'..'Z')
Wires   = (0..Letters.count - 1)

Input  = Hash[Letters.zip(Wires)]
Output = Input.invert

Plugboard = Hash[*Letters.to_a.shuffle.first(20)]
Plugboard.merge!(Plugboard.invert)
Plugboard.default_proc = proc { |hash, key| key }

Reflector = Hash[*Wires.to_a.shuffle]
Reflector.merge! Reflector.invert

Rotors = (0..2).map { Wires.to_a.shuffle }

def process(str)
  rotors = Rotors.map &:dup
  str.chars.each_with_index.map do |char, step|
    rotors.each_with_index {|rotor, i| rotor << rotor.shift if (step % Letters.count ** i) == 0}

    signal = Input[ Plugboard[char] ]

    rotors.each         {|rotor| signal = rotor[signal]}
    signal = Reflector[signal]
    rotors.reverse.each {|rotor| signal = rotor.index(signal) }

    Plugboard[ Output[signal] ]
  end.join
end

plain_text = 'helloworld'.upcase
puts "Encrypted '#{plain_text}' to '#{encrypted = process(plain_text)}'"
puts "Decrypted '#{encrypted}' to '#{decrypted = process(encrypted)}'"
puts 'Success!' if plain_text == decrypted
