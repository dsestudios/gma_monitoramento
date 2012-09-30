# encoding: UTF-8

require 'mongoid_paperclip'

class Camera
  include Mongoid::Document
  include Mongoid::Paperclip

  field :nome, :type => String
  field :numero_camera, :type => Integer

  #relacionamentos
  has_many :camera_defeitos
  has_many :monitoramento_ocorrencias
  has_and_belongs_to_many :monitoramentos, index: true


  has_mongoid_attached_file :foto_do_lugar,
                            :styles => {:medium => "300x300>", :thumb => "100x100>"},
                            :default_url => "sem_foto.jpg"

  validates_presence_of	:nome, :numero_camera
  validates_numericality_of :numero_camera, :only_integer => true, :message => I18n.t("validation.must_be_number")
  validates_length_of :numero_camera, :in => 1..3
  validates_uniqueness_of :numero_camera

end
