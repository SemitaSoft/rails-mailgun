require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module MailgunWebclient

  class Application < Rails::Application
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'mailgun_config.yml')
      YAML.load(File.open(env_file)).each do |key, value|
      ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
    config.active_record.raise_in_transactional_callbacks = true
  end
end
