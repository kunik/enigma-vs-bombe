require_relative './drums_block'

module Bombe
  class TestRegister
    attr_reader :drums, :drums_block, :key_path

    def initialize(input, crip)
      @input       = input
      @crip        = crip
      @drums_block = Bombe::DrumsBlock.new()
      @root        = ::Pathname.new ::File.expand_path('../..', __FILE__)
      _save!
    end

    def compare!
      config = Enigma::Config.new
      enigma = Enigma::Machine.new config
      dec    = enigma.process(@input)
      return yield(_save_key!) if dec == @crip
      _next!
    end

    private
    def _save!
      path             = @root.join('config.yml')
      config           = ::YAML::load_file(path)
      config['rotors'] = @drums_block.drums.map(&:mapping)
      ::File.open(path, 'w') do |f|
        f.write config.to_yaml
      end
    end

     def _save_key!
      ::File.open(@root.join('bombe_key.yml'), 'w') do |f|
        f.write ::YAML::load_file(@root.join('config.yml')).to_yaml
      end
    end

    def _next!
      @drums_block.step!
      _save!
    end
  end
end
