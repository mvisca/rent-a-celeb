# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

Review.destroy_all
puts "Delete reviews"

Reservation.destroy_all
puts "Delete reservations"

Celebrity.destroy_all
puts "Delete celebities"

User.destroy_all
puts "Delete users"

user = User.create(
  email: 'm@m.m',
  first_name: 'Martin',
  last_name: 'Martin',
  password: '111111'
)

puts "Create user m@m.m / 111111"

10.times do
  User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '111111'
  )
  # user.save(validate: false)
end
puts "Create 10 users"

10.times do
  Celebrity.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.city, #city no existe en la base de datos
    description: Faker::Demographic.race,
    price: [120, 220, 325, 595].sample,
    user_id: User.all.sample.id
  )
  photo = URI.open('https://thispersondoesnotexist.com/image')
  Celebrity.last.photo.attach(
    io: photo,
    filename: 'image.jpg',
    content_type: 'image/jpg'
  )
  # celebrity.save(validate: false)
end
puts "Create 20 celebrities"

statux = ['confirmed', 'pending']
10.times do
  Reservation.create(
    reserve_begin: '20.06.2022',
    reserve_end: '20.07.2022',
    status: statux.sample,
    celebrity_id: Celebrity.all.sample.id,
    user_id: User.all.sample.id
  )
  # reservation.save(validate: false)
end
puts "Create 10 reservations"

30.times do
  review = Review.create(
    content: Faker::ChuckNorris.fact,
    rating: rand(0..50) / 10.0,
    reservation_id: Reservation.all.sample.id
  )
  # review.save(validate: false)
end
puts "Create 30 reviews"
