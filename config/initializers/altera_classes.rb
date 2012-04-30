#encoding: UTF-8

class TrueClass

  def to_s_br
    "Sim"
  end

end

class FalseClass

  def to_s_br
    "Não"
  end

end

class Object

    def self.nome_exibicao
      get_display_name false
    end

    def self.nome_exibicao_plural
      get_display_name true
    end

    private

    def self.get_display_name(plural)
      tag = plural ? "plural" : "singular"
      I18n.t("models_display_names.#{name.downcase}.#{tag}", :default => plural ? name.pluralize : name)
    end

end