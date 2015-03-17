require_relative '../enigma'

module Bombe
  class Drum
    attr_reader :mapping
    def initialize mapping
      @mapping = mapping
    end

    def rotate!
      mapping.rotate!
    end

    def size
      mapping.size
    end

    class << self
      def default_config
        (0..::Enigma::Letters.count - 1).to_a
      end
    end
  end
end