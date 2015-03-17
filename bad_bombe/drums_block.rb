require_relative './drums'


module BadBombe
  class DrumsBlock
    attr_reader :drums

    def initialize
      @drums = Drums.new
      @step  = 0
    end

    def step!
      @step += 1
      drums.each_with_index {|drum, i| drum.rotate! if (@step % drum.size ** i) == 0}
    end

  end
end