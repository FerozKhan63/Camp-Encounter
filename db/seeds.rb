# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!( id: 1, email: "admin@campencounter.com", password: "Password123!@#", password_confirmation: "Password123!@#",first_name: "admin",country: "PK",phone_number: "323-595-0000", country_code: "92", role: 2)
User.create!( id: 2, email: "s.admin@campencounter.com", password: "Password123!@#", password_confirmation: "Password123!@#",first_name: "superAdmin",country: "PK",phone_number: "323-595-8888", country_code: "92", role: 1)