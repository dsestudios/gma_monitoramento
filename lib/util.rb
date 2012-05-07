class Util

  class << self

    #MANAHA = 6h01h a 12h - M
    #TARDE = 12H01 a 18h - T
    #NOITE = 18h01 as 00h00 - N
    #MADRUGADA = 00h01 as 6h - D
    def periodo_atual
      agora = Time.now
      manha = periodo_hora_inicial("M", agora)
      tarde = periodo_hora_inicial("T", agora)
      noite = periodo_hora_inicial("N", agora)
      madrugada = periodo_hora_inicial("D", agora)

      return "N" if agora > noite
      return "T" if agora > tarde
      return "M" if agora > manha
      return "D" if agora > madrugada

      "N"
    end

    def periodo_descricao(periodo="")
      periodo = periodo_atual if periodo.blank?
      return I18n.t("termos.periodo.manha") if periodo == "M"
      return I18n.t("termos.periodo.tarde") if periodo == "T"
      return I18n.t("termos.periodo.noite") if periodo == "N"
      return I18n.t("termos.periodo.madrugada") if periodo == "D"
    end

    def periodo_carga_horaria periodo
      return 6.hours if periodo == "M"
      return 6.hours if periodo == "T"
      return 6.hours - 1.minute if periodo == "N"
      return 6.hours if periodo == "D"
    end

    def periodo_hora_inicial periodo, agora = Time.now
      return Time.new(agora.year, agora.month, agora.day, 0) if periodo == "D"
      return Time.new(agora.year, agora.month, agora.day, 6) if periodo == "M"
      return Time.new(agora.year, agora.month, agora.day, 12) if periodo == "T"
      return Time.new(agora.year, agora.month, agora.day, 18) if periodo == "N"

      # COM A ADIÇÃO DA MADRUGADA ISSO NAO EXISTE MAIS
      #tratamento no caso da NOITE
      #caso seja começo da noite então a hora inicial deve retroceder 1 dia,
      #pois o turno noturno começa as 18h e termina as 6h do outro dia
      #if periodo == "N"
      #  if agora.hour < 6
      #    agora = agora.ago(1.day)
      #  end
      #  return Time.new(agora.year, agora.month, agora.day, 18)
      #end

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

    #total de registros por paginas nos relatorios
    def paginacao_relatorio
      27
    end

  end

end