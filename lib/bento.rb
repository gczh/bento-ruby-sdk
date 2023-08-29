require 'bento_v2/version'
require 'bento_v2/client'
require 'bento_v2/configuration'

require 'logger'
require 'forwardable'

module Bento
  class Error < StandardError; end

  class ArgumentError < Error; end

  class ConfigurationError < Error
    attr_reader :key

    def initialize(key)
      @key = key.to_sym

      super <<~CONFIG_ERROR_MESSAGE
        Missing config value for `#{key}`

        Please set a value for `#{key}` using an environment variable:

          BENTO_#{key.to_s.upcase}=your-value

        or via the `Bento.configure` method:

          Bento.configure do |config|
            config.#{key} = 'your-value'
          end
      CONFIG_ERROR_MESSAGE
    end
  end

  class << self
    extend Forwardable
    
    # User configurable options
    def_delegators :@config, :site_uuid, :site_uuid=
    def_delegators :@config, :publishable_key, :publishable_key=
    def_delegators :@config, :secret_key, :secret_key=
    def_delegators :@config, :log_level, :log_level=

    def config
      @config ||= Bento::Configuration.new
    end

    def logger
      @logger ||= begin
        logger = Logger.new($stdout)
        logger.progname = 'bento'
        logger.level = Logger.const_get(config.log_level.to_s.upcase)
        logger
      end
    end

    def configure
      yield config
    end

    def reset!
      @config = nil
    end

    attr_writer :logger
  end
end