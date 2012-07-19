# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#puts 'Limpando bando de dados'
#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'Criando usuarios de teste'
user = User.create! :nome => 'Administrador', :nome_usuario => 'admin', :email => 'admin@admin.com', :password => 'admin1', :password_confirmation => 'admin1', :role => "admin"
User.create! :nome => 'Monitor', :nome_usuario => 'monitor', :email => 'monitor@monitor.com', :password => 'monitor', :password_confirmation => 'monitor', :role => "monitor"
puts "Usuarios criados."
puts "Usuário Adm: " << user.nome + " - " + user.nome_usuario + " - " + user.password

#dados = DadosSemente.new
#puts dados.cria_todas_ocorrencia ? "Ocorrencias criadas" : "Ocorrencias NÃO criadas"
#puts dados.cria_todas_cameras ? "Cameras criadas" : "Cameras NÃO criadas"
