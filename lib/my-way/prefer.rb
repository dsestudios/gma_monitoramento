module MyWayModule
  class Prefer
    attr_accessor :nickname, :default, :action

    def initialize (nickname=nil, default=nil, action=nil)
      @nickname = nickname
      @default = default
      @action = action
    end
  end
end

