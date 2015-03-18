
crib   = 'WETTERVORHERSAGEBISKAYA'
cipher = 'RWIVTYRESXBFOGKUHQBAISE'

class CribToCipher < Array
  def initialize crib, cipher
    super crib.size.times.map { |i| [crib[i], cipher[i]] }
  end

  def > i
    ([ self[i] ] << self[i].reverse).to_h
  end
end

crib_to_cipher = CribToCipher.new crib, cipher
p crib_to_cipher[4]
p crib_to_cipher > 4