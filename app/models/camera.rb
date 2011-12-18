class Camera
  include Mongoid::Document
  field :nome, :type => String
  field :numero_camera, :type => Integer

  validates_presence_of	:nome, :numero_camera
  validates_numericality_of :numero_camera, :only_integer => true
end
