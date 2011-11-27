# encoding: UTF-8
require 'mongoid_paperclip'

class User
  include Mongoid::Document
  include Mongoid::Paperclip

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_mongoid_attached_file :avatar,
                            :styles => {:medium => "300x300>", :thumb => "100x100>"},
                            :default_url => "no_avatar.jpg"

  field :nome
  field :nome_usuario
  field :role

  validates_presence_of :nome, :nome_usuario
  validates_uniqueness_of :nome_usuario, :email, :case_sensitive => false

  attr_accessible :nome, :nome_usuario, :email, :password, :password_confirmation, :remember_me, :role, :avatar

  #retorna a descrição do papel do usuário de acordo com a seu campo Role
  def role_descricao
    Ability.tipos_de_usuarios[role.to_sym]
  end

end
