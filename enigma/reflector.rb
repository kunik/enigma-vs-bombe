require_relative 'letters'
require_relative 'wiring'

module Enigma
  class Reflector < Wiring
    def initialize(mapping)
      @mapping = mapping
      @mapping.merge! @mapping.invert
    end
    class << self
      def default_config
        Hash[*(0..Letters.count - 1).to_a.shuffle]
      end
    end
  end
end