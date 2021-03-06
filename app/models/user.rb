# encoding: UTF-8
require 'mongoid_paperclip'

class User
  include Mongoid::Document
  include Mongoid::Paperclip

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable

  has_mongoid_attached_file :avatar,
                            :styles => {:medium => "300x300>", :thumb => "100x100>"},
                            :default_url => "no_avatar.jpg"

  field :nome
  field :nome_usuario
  field :role

  #relacionamentos
  has_many :monitoramentos

  validates_presence_of :nome, :nome_usuario, :email
  validates_presence_of :password, :password_confirmation, :on => :create
  validates_length_of :nome, :in => 3..50
  validates_length_of :nome_usuario, :in => 3..20
  validates_length_of :email, :in => 5..30
  validates_length_of :password, :in => 6..20, :allow_blank => true, :on => :update
  validates_uniqueness_of :nome_usuario, :email, :case_sensitive => false

  attr_accessible :nome, :nome_usuario, :email, :password, :password_confirmation, :remember_me, :role, :avatar

  index({nome_usuario: 1}, { unique: true })

  #retorna a descrição do papel do usuário de acordo com a seu campo Role
  def role_descricao
    Ability.tipos_de_usuarios[role.to_sym]
  end

end
