class Array
  def not_eq? array
    !!self.size.times { |i| break if self[i] == array[i] }
  end
end

crip   = 'WETTERVORHERSAGEBISKAYA'.split('')
# => ['W', 'E', 'T', ...]
cipher = 'QFZWRWIVTYRESXBFOGKUHQBAISEZ'.split('')

cipher.size.times do |i|
  crip_key = cipher.rotate(i).slice(0, crip.size)
  p(crip_key.join) && break if crip_key.not_eq? crip
end