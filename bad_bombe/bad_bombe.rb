require_relative '../enigma'
require_relative './test_register'

Enigma::Config.include ::Kernel

module BadBombe
  class Machine
    attr_reader :input, :crip

    def initialize input, crip
      @input            = input
      @crip             = crip
      _init_config
    end

    def power_on!
      17576.times do
        p('Found') && break if @found
        _atempt
      end
    end

    private
    def _init_config
      @test_register ||= BadBombe::TestRegister.new(@input, @crip)
    end

    def _atempt
      @test_register.compare! { |x| @found = x }
    end
  end
end