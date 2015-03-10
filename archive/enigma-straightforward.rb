Input = Hash[('A'..'Z').zip(0..25)]
Output = Input.invert

Plugboard = Hash[*('A'..'Z').to_a.shuffle.first(20)]
Plugboard.merge!(Plugboard.invert)
Plugboard.default_proc = proc { |hash, key| key }

Reflector = Hash[*(0..25).to_a.shuffle]
Reflector.merge! Reflector.invert

Rotors = [
  (0..25).to_a.shuffle,
  (0..25).to_a.shuffle,
  (0..25).to_a.shuffle ]

def process(str)
  step = 0
  rotors = [
    Rotors[0].dup,
    Rotors[1].dup,
    Rotors[2].dup,
  ]

  str.chars.map do |char|
    step += 1

    rotors[0] << rotors[0].shift
    rotors[1] << rotors[1].shift if step % 26 == 0
    rotors[2] << rotors[2].shift if step % (26 * 26) == 0

    char = Plugboard[char]

    x = Input[char]
    x = rotors[0][x]
    x = rotors[1][x]
    x = rotors[2][x]
    x = Reflector[x]
    x = rotors[2].index(x)
    x = rotors[1].index(x)
    x = rotors[0].index(x)

    char = Output[x]
    char = Plugboard[char]
  end.join
end

plain_text = 'helloworld'.upcase
puts "Encrypted '#{plain_text}' to '#{encrypted = process(plain_text)}'"
puts "Decrypted '#{encrypted}' to '#{decrypted = process(encrypted)}'"
puts 'Success!' if plain_text == decrypted

