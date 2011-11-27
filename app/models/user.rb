class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :nome
  field :login

  validates_presence_of :nome, :login
  validates_uniqueness_of :login, :email, :case_sensitive => false

  attr_accessible :nome, :login, :email, :password, :password_confirmation, :remember_me

end
