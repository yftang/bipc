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
             { :name => 'BioinformaticianAdmin' },
             { :name => 'Bioinformatician' }])
admin_role.users.create({ :email                 => 'admin@admin.com',
                          :name                  => 'Administrator',
                          :password              => 'foobar',
                          :password_confirmation => 'foobar'})
