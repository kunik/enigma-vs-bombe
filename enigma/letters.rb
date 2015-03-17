require_relative 'config'

module Enigma
  class_eval do
    define_letters = lambda do |letters|
      Enigma.const_set :Letters, letters

      Letters.define_singleton_method(:configure!) do |letters|
        Enigma.send(:remove_const, :Letters)
        define_letters.call letters
      end

      Letters.define_singleton_method(:default_config) do
        letters
      end

      Letters.define_singleton_method(:range) do
        (0..letters.count-1)
      end
    end

    define_letters.call ('A'..'Z').to_a
  end
end
