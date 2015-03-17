require_relative 'enigma/machine'
require_relative 'enigma/config'

module Enigma
  module_function
  def configure(config=nil)
    @machine = Machine.new(config || Config.new)
  end
end

