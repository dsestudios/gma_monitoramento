#encoding: UTF-8

FactoryGirl.define do
  factory :user do
    nome "Operador"
    nome_usuario "operador" #"#{nome}"
    email "operador@operador.com" #"#{nome}@#{nome}gmail.com"
    password "operador"
    password_confirmation "Operador"
    role :monitor
  end

  factory :admin, class: User do
    nome "Admin"
    nome_usuario "Admin"
    email "admin@admin.com" #"#{nome}@#{nome}gmail.com"
    password "admin1"
    password_confirmation "admin1"
    role :admin
  end
end

FactoryGirl.define do
  factory :camera do
    nome "R1 x Duque"
    numero_camera 1
  end
end

FactoryGirl.define do
  factory :ocorrencia_item do
    descricao "Atentado ao pudor"
    monitoramentos
  end
end

FactoryGirl.define do
  factory :ocorrencia do
    grupo "Acionamento PM"
    association :ocorrencia_itens, factory: :ocorrencia_item
    association :ocorrencia_itens, factory: :ocorrencia_item, descricao: "Atitude suspeita"
  end
end

FactoryGirl.define do
  factory :visor do
    nome "Mesa 1"
    numero 1
  end

  factory :mesa_2, class: Visor do
    nome "Mesa 2"
    numero 2
  end

  factory :mesa_3, class: Visor do
    nome "Mesa 3"
    numero 3
  end
end

FactoryGirl.define do
  p = Util.periodo_hora_inicial_e_final(Util.periodo_atual)
  factory :monitoramento do
    data p[:inicio]
    data_final p[:fim]
    periodo Util.periodo_atual
    novidades "Aqui estão descritas as novidades"
    efetivado false
    association :user, factory: :user
    association :visor, factory: :visor
  end
end

  #has_many :camera_defeitos
  #has_and_belongs_to_many :cameras
  #has_and_belongs_to_many :ocorrencia_itens


