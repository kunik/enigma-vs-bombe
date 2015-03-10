require_relative 'concerns/configurable'

module Enigma
  class Wiring
    extend Configurable
    attr_reader :mapping

    def convert(signal)
      mapping[signal]
    end

    alias :<< :convert
  end
end