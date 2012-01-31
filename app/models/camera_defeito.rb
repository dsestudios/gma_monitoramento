class CameraDefeito
  include Mongoid::Document

  field :defeito, :type => String
  belongs_to :camera

end