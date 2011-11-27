class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  field :nome
  field :nome_usuario
  field :role

  validates_presence_of :nome, :nome_usuario
  validates_uniqueness_of :nome_usuario, :email, :case_sensitive => false

  attr_accessible :nome, :nome_usuario, :email, :password, :password_confirmation, :remember_me, :role

end
