require 'my-way/base'
require 'my-way/conf'
require 'my-way/prefer'
require 'my-way/adapter/mongoid'

class MyWay
  extend MyWayModule::Base

  def self.configuration_db
    Configuration
  end

  add_conf(:login_timeout, 20) do |c|
    Devise.setup do |config|
      config.timeout_in = c.value.minutes
    end
  end

  remove_configurations_not_existing

end