require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Plugboard < Wiring
    def initialize(pairs)
      @mapping = pairs.dup
      @mapping.default_proc = proc { |hash, key| key }
      @mapping.merge! @mapping.invert
    end

    class << self
      def default_config
        Hash[*Letters.shuffle.take(20)]
      end
    end
  end
end