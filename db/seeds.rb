# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_role = Role.create({ :name => 'Admin' })
Role.create([{ :name => 'SalesmanAdmin' },
             { :name => 'Salesman' },
             { :name => 'MarketingAdmin' },
             { :name => 'Marketing' },
             { :name => 'ExperimenterAdmin' },
             { :name => 'Experimenter' },
             { :name => 'BioinformaticianAdmin' },
             { :name => 'Bioinformatician' }])
admin_role.users.create({
  :email => 'admin@admin.com',
  :name  => 'Administrator'
})
Role.find_by_name('SalesmanAdmin').users.create({
  :email => 'smn_admin@admin.com',
  :name  => 'SalesmanAdmin'
})
Role.find_by_name('Salesman').users.create({
  :email => 'smn@admin.com',
  :name  => 'Salesman'
})
Role.find_by_name('MarketingAdmin').users.create({
  :email => 'mkt_admin@admin.com',
  :name  => 'MarketingAdmin'
})
Role.find_by_name('Marketing').users.create({
  :email => 'mkt@admin.com',
  :name  => 'Marketing'
})
Role.find_by_name('ExperimenterAdmin').users.create({
  :email => 'exp_admin@admin.com',
  :name  => 'ExperimenterAdmin'
})
Role.find_by_name('Experimenter').users.create({
  :email => 'exp@admin.com',
  :name  => 'Experimenter'
})
Role.find_by_name('BioinformaticianAdmin').users.create({
  :email => 'bin_admin@admin.com',
  :name  => 'BioinformaticianAdmin'
})
Role.find_by_name('Bioinformatician').users.create({
  :email => 'bin@admin.com',
  :name  => 'Bioinformatician'
})
