module Enigma
  class Wiring
    attr_reader :mapping

    def convert(signal)
      mapping[signal]
    end

    alias :<< :convert
  end
end