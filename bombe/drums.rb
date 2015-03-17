require_relative './drum'

module Bombe
  class Drums
    include Enumerable
    attr_reader :drums

    def initialize
      @drums = 3.times.map { Drum.new (0..::Enigma::Letters.count - 1).to_a }
    end

    def each(&block)
      @drums.each(&block)
    end
  end
end