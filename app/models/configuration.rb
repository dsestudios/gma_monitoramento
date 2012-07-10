require "yaml"

#TODO colocar novo campo TYPE que define se é INT ou String e ai fazer o tratamento correto, já devolvendo o valor no seu tipo correto
#TODO pensar sobre uma forma de aplicar as configuraçoes de forma direta com alguma implementaçao especial

class Configuration
  include Mongoid::Document

  field :nickname, :type => String
  field :value, :type => String

  validates_uniqueness_of :nickname

  def value
    return default if @attributes["value"].nil? or @attributes["value"].blank?
    @attributes["value"]
  end

  def name
    I18n.t("configuration.#{nickname}.name")
  end

  def description
    I18n.t("configuration.#{nickname}.description")
  end

  def default
    Configuration.file[nickname]["default"]
  end

  def unit
    I18n.t("configuration.#{nickname}.unit")
  end

  class << self
    @@file_configuration = YAML::load(File.open("config/configuration.yml"))

    def file
      @@file_configuration
    end

    def file_reload
      @@file_configuration = YAML::load(File.open("config/configuration.yml"))
    end

    def load_conf(nickname)
      Configuration.where(:nickname => nickname.to_s).first
    end

    def method_missing(symbol, *args)
       load_conf(symbol.to_s)
    end

    def exist?(nickname)
       not load_conf(nickname).nil?
    end

  end

end
