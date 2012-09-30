require "my-way/conf"

class Configuration
  include Mongoid::Document
  include MyWayModule::Conf

  after_save do |document|
    document.execute_action
  end

  field :nickname, :type => String
  field :value, :type => String

  index({nickname: 1}, { unique: true })
end
