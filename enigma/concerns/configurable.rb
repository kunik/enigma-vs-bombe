module Configurable
  def default_config(&block)
    instance_eval do
      define_singleton_method(:default_config, &block)
    end
  end
end