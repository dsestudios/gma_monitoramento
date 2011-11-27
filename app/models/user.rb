class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  field :nome
<<<<<<< HEAD
  field :login
  field :role
=======
  field :nome_usuario
>>>>>>> 6e8267222776a6b734d467f42a021688e382bfe9

  validates_presence_of :nome, :nome_usuario
  validates_uniqueness_of :nome_usuario, :email, :case_sensitive => false

<<<<<<< HEAD
  attr_accessible :nome, :login, :email, :password, :password_confirmation, :remember_me, :role
=======
  attr_accessible :nome, :nome_usuario, :email, :password, :password_confirmation, :remember_me
>>>>>>> 6e8267222776a6b734d467f42a021688e382bfe9

end
