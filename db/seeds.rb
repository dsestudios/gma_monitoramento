# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'Banco de dados vazio'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'Criando user padrão'
user = User.create! :nome => 'Usuário Teste', :login => 'teste', :email => 'joaoaugusto1@gmail.com', :password => 'teste123', :password_confirmation => 'teste123', :role => "admin"
user = User.create! :nome => 'Blog', :login => 'blog', :email => 'blog@blog.com.br', :password => 'blog123', :password_confirmation => 'blog123', :role => "blog"
user = User.create! :nome => 'Test', :login => 'test', :email => 'test@test.com.br', :password => 'test123', :password_confirmation => 'test123', :role => "test"
puts 'Novo usuário criado: ' << user.nome + " - " + user.login