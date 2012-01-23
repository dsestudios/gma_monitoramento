class Util

  class << self

    #MANAHA = 6h01h a 12h
    #TARDE = 12H01 a 18h
    #NOITE = 18h01 as 6h
    def periodo_atual
      agora = Time.now
      manha = Time.new(agora.year, agora.month, agora.day, 6)
      tarde = Time.new(agora.year, agora.month, agora.day, 12)
      noite = Time.new(agora.year, agora.month, agora.day, 18)

      return "N" if agora > noite
      return "T" if agora > tarde
      return "M" if agora > manha

      "N"
    end

    def periodo_descricao(periodo="")
      periodo = periodo_atual if periodo.blank?
      return I18n.t("termos.periodo.manha") if periodo == "M"
      return I18n.t("termos.periodo.tarde") if periodo == "T"
      return I18n.t("termos.periodo.noite") if periodo == "N"
    end

  end

end