module MyWayModule
  module Base

    def configuration_db
      #Sobrescrever apontando para a classe model que representa as configuracao no banco
    end

    def add_conf(nickname, default, options = {}, &after_change)
      options[:execute_initialization] ||= true

      configuratios[nickname] = Prefer.new(nickname, default, after_change)

      conf_db = load_conf(nickname)
      if conf_db.nil?
        conf_db = configuration_db.create!(:nickname => nickname, :value => default)
      end

      conf_db.execute_action if options[:execute_initialization]
    end

    def remove_configurations_not_existing
      conf_db = configuration_db.all
      conf_db.each do |c|
        if not configuratios.has_key?(c.nickname.to_sym)
          c.destroy
        end
      end
    end

    def get_conf(nickname)
      configuratios[nickname.to_sym]
    end

    def configuratios
      @configurations ||= {}
    end

    def load_conf(nickname)
      configuration_db.where(:nickname => nickname.to_s).first
    end

    def method_missing(symbol, *args)
      if symbol.to_s[0,5] == "pref_"
        symbol = symbol.to_s[5,symbol.to_s.length].to_sym
        load_conf(symbol) if configurations.has_key?(symbol)
      end
    end

    def exist?(nickname)
      not load_conf(nickname).nil?
    end

  end
end