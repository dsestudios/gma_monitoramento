class Util

  class << self

    #MANAHA = 6h01h a 12h
    #TARDE = 12H01 a 18h
    #NOITE = 18h01 as 6h
    def periodo_atual
      agora = Time.now
      manha = periodo_hora_inicial("M", agora)
      tarde = periodo_hora_inicial("T", agora)
      noite = periodo_hora_inicial("N", agora)

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

    def periodo_carga_horaria periodo
      return 6.hours if periodo == "M"
      return 6.hours if periodo == "T"
      return 12.hours if periodo == "N"
    end

    def periodo_hora_inicial periodo, agora = Time.now
      return Time.new(agora.year, agora.month, agora.day, 6) if periodo == "M"
      return Time.new(agora.year, agora.month, agora.day, 12) if periodo == "T"

      #tratamento no caso da NOITE
      #caso seja começo da noite então a hora inicial deve retroceder 1 dia,
      #pois o turno noturno começa as 18h e termina as 6h do outro dia
      if periodo == "N"
        if agora.hour < 6
          agora = agora.ago(1.day)
        end
        return Time.new(agora.year, agora.month, agora.day, 18)
      end

    end

    # Retorna HASH a hora inicial e final de um periodo de acordo com a data informada
    # RETORNA:
    # :inicio => Data Inicial
    # :fim => Hora Final
    def periodo_hora_inicial_e_final periodo, data = Time.now
      inicio = periodo_hora_inicial(periodo, data)
      fim = inicio + periodo_carga_horaria(periodo)
      return {:inicio => inicio, :fim => fim}
    end

  end

end