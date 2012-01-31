# encoding: UTF-8

class DadosSemente

  def cria_todas_ocorrencia
    cria_ocorrencia("VISUALIZAÇÃO", itens_visualizacao)
    cria_ocorrencia("ACIONAMENTO CAD", itens_cad)
    cria_ocorrencia("ACIONAMENTO PM", itens_pm)
    cria_ocorrencia("ANÁLISE DE VÍDEOS/IMAGENS", itens_analise)
  end

  def cria_todas_cameras
    cria_cameras("9 Julho X Barroso", 18)
    cria_cameras("Alameda X Vaz Filho", 16)
    cria_cameras("Barroso X Rua 3", 14)
    #cria_cameras("Bento X Rua 2", 14)
    cria_cameras("Botanico", 10)
    cria_cameras("Caravan", 3)
    #cria_cameras("CECAP", 10)
    cria_cameras("CTA", 4)
    #cria_cameras("CECAP", 10)
    #cria_cameras("Feijo X Rua 2", 4)
    cria_cameras("Matriz", 8)
    cria_cameras("Padre Anchieta", 13)
    #cria_cameras("Parque Infantil", 13)
    cria_cameras("Pedro de Toledo", 2)
    cria_cameras("Prefeitura", 7)
    cria_cameras("Presidente Vargas", 6)
    cria_cameras("R16 x Av 36", 5)
    cria_cameras("Rodoviaria", 9)
    cria_cameras("Roseiras", 22)
    cria_cameras("Rota Indaia", 20)
    cria_cameras("Savegnago", 21)
    cria_cameras("Santa Cruz", 23)
    cria_cameras("Teatro", 17)
    cria_cameras("Vaz Filho", 19)
  end

  def cria_cameras(nome, numero)
    c = Camera.new
    c.nome = nome
    c.numero_camera = numero
    c.save
  end

  def cria_ocorrencia(grupo, itens)
    o = Ocorrencia.new
    o.grupo = grupo
    #o.ocorrencia_itens = itens
    if !o.save
      puts grupo + " - " + o.errors.to_s
    end
    get_ocorrencia_itens(o, itens)
  end

  def get_ocorrencia_itens(ocorrencia, descricoes)
    itens = []
    descricoes.each do |d|
      oi = OcorrenciaItem.new
      oi.ocorrencia = ocorrencia
      oi.descricao = d
      if !oi.save
        puts ocorrencia.grupo + " - " + oi.errors.to_s
      end
      itens << oi
    end

    itens
  end

  def itens_visualizacao
    ["PESSOAS EM ATITUDE SUSPEITA",
    "USO/TRÁFICO DE ENTORPECENTES",
    "FURTO/ROUBO/DANO",
    "CÓDIGO DE POSTURAS/OBRAS",
    "ASSISTÊNCIA SOCIAL",
    "CRIME/INFRAÇÃO AMBIENTAL",
    "OUTROS RELACIONADOS À GCM",
    "ACIDENTE DE TRÂNSITO",
    "INFRAÇÃO DE TRÂNSITO",
    "ATROPELAMENTO",
    "IMPRUDÊNCIA NO TRÂNSITO",
    "TRÂNSITO LENTO/PARADO",
    "VEÍCULOS QUEBRADOS",
    "ANIMAIS NA VIA",
    "ÓLEO NA VIA",
    "OUTROS RELACIONADOS AO TRÂNSITO",
    "ALAGAMENTO/INUNDAÇÃO",
    "QUEDA DE ÁRVORE",
    "OUTROS RELACIONADOS À DEFESA CIVIL"]
  end

  def itens_cad
    ["PESSOAS EM ATITUDE SUSPEITA",
    "USO/TRÁFICO DE ENTORPECENTES",
    "FURTO/ROUBO/DANO",
    "CÓDIGO DE POSTURAS/OBRAS",
    "ASSISTÊNCIA SOCIAL",
    "CRIME/INFRAÇÃO AMBIENTAL",
    "OUTROS RELACIONADOS À GCM",
    "ACIDENTE DE TRÂNSITO",
    "INFRAÇÃO DE TRÂNSITO",
    "ATROPELAMENTO",
    "IMPRUDÊNCIA NO TRÂNSITO",
    "TRÂNSITO LENTO/PARADO",
    "VEÍCULOS QUEBRADOS",
    "ANIMAIS NA VIA",
    "ÓLEO NA VIA",
    "OUTROS RELACIONADOS AO TRÂNSITO",
    "ALAGAMENTO/INUNDAÇÃO",
    "QUEDA DE ÁRVORE",
    "OUTROS RELACIONADOS À DEFESA CIVIL"]
  end

  def itens_pm
    ["USO/TRÁFICO DE ENTORPECENTES",
     "FURTO/ROUBO/DANO",
    "OUTROS CRIMES"]
  end

  def itens_analise
    ['OUVIDAS VIA REDE DE RÁDIO',
    'SOLICITAÇÃO VIA PROTOCOLO PMA',
    'SOLICITAÇÃO VIA CAD',
    'SOLICITAÇÃO VIA OUTRAS INSTITUIÇÕES']
  end

end
