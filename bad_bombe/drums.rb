require_relative './drum'

module BadBombe
  class Drums
    include Enumerable
    attr_reader :drums

    def initialize
      path = ::Pathname.new(::File.expand_path('../..', __FILE__)).join('config.yml')
      original_wiring = ::YAML::load_file(path)
      @drums = original_wiring['rotors'].map { |r| r.rotate Random.rand(26) }
    end

    def each(&block)
      @drums.each(&block)
    end
  end
end