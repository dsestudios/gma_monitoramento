class CameraDefeito
  include Mongoid::Document

  field :defeito, :type => String
  belongs_to :camera
  belongs_to :monitoramento

  #validates_presence_of :defeito
  validates_uniqueness_of :defeito, :case_sensitive => false, :scope => [:monitoramento_id, :camera_id]
  validates_associated :camera

end