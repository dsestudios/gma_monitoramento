module MyWayModule
  module Adapter
    module Mongoid
      def nickname
        @attributes["nickname"]
      end

      def value
        return default if @attributes["value"].nil? or @attributes["value"].blank?
        parse_value(@attributes["value"])
      end
    end
  end
end