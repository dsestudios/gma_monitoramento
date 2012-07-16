require "my-way/adapter/mongoid"

module MyWayModule
  module Conf
    include MyWayModule::Adapter::Mongoid

    def execute_action()
      action.call(self) if not action.nil?
    end

    def default
      MyWay.get_conf(nickname).default
    end

    def action
      MyWay.get_conf(nickname).action
    end

    def name
      I18n.t("my_way.#{nickname}.name")
    end

    def description
      I18n.t("my_way.#{nickname}.description")
    end

    def unit
      I18n.t("my_way.#{nickname}.unit")
    end

    def value_type
      default.class
    end

    def parse_value(value)
      return value.to_i if default.is_a?(Fixnum)
      return value
    end

  end
end