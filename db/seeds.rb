# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


institutions_sigla = ['UFU','UNITRI','UFMG','USP','UFRJ','UFPR','UFTM','IFTM']
institutions_NAME  = ['Universidade Federal de Uberlândia','Centro universitário do Triângulo',
                      'Universidade Federal de Minas Gerais','Universidade de São Paulo',
                      'Univerisidade Federal do Rio de Janeiro','Universidade Federal do Paraná',
                      'Universidade Federal do Triângulo Mineiro','Instituto Federal do Triângulo Mineiro']

i=0
institutions_NAME.each do |x|
  Admin::Institution.create(name: x,acronym: institutions_sigla[i])

  i = i + 1
end