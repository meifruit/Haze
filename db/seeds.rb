# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'fileutils'
puts "cleaning users and bookings..."
Booking.destroy_all
User.destroy_all

genders = ["male", "female"]
title_service = ["Boyfriend", "Girlfriend", "Soulmate", "Datemate", "Datefusion", "Heartsync", "LoveHaven", "RomanceRevolution"]
location = ["Shibuya, Tokyo", "Roppongi, Tokyo", "Shinjuku, Tokyo", "Okinawa", "Osaka", "Kyoto", "Hiroshima"]
status = ["pending", "rejected", "accepted", "completed"]

testuser = User.create(
  name: "testuser",
  interest: "human observation",
  location: "Meguro,Tokyo",
  sex: "male",
  description: Faker::Quote.most_interesting_man_in_the_world,
  age: 20,
  email: "test@email.com",
  password: "123456"
)

puts "created test user"

john = User.create(
    name: "John Doe",
    interest: "Writing",
    location: "Meguro,Tokyo",
    sex: "male",
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: rand(18..50),
    email: "john@email.com",
    password: "123456"
  )

20.times do
  user = User.create!(
    name: Faker::Name.name,
    interest: Faker::Hobby.activity,
    location: location.sample,
    sex: genders.sample,
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: rand(18..50),
    email: Faker::Internet.email,
    password: "123456"
  )

  puts "created #{User.count} users!"

  service = Service.new(
    user: user,
    title: title_service.sample,
    description: user.description,
    price: rand(100..500)
  )

    # gender options: 'all' or 'male' or 'female'
    gender = 'all'
    # age options: 'all' or '12-18' or '19-25' or '26-35' or '35-50' or '50+'
    age = '26-35'
    # ethnicity options: 'all' or 'asian' or 'white' or 'black' or 'indian' or 'middle_eastern' or 'latino_hispanic'
    ethnicity = 'all'

  5.times do
    url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
    json = URI.open(url).read
    src = JSON.parse(json)['src']
    photo_url = "https://this-person-does-not-exist.com#{src}"
    file = URI.open(photo_url)
    service.photos.attach(io: file, filename: 'user.png', content_type: 'image/png')
    service.save
  end

  5.times do
    Review.create!(
    rating: rand(3..5),
    comment: Faker::Restaurant.review,
    user: User.where.not(id: user).sample,
    service: service
    )
  end
end

puts "created #{Service.count} services!"
puts "created #{Review.count} reviews!"

Service.all.each do |service|
  rand(1..4).times do
    booking = Booking.create!(
      user: User.where.not(id: service.user).sample,
      service: service,
      status: status.sample,
      start_date: Date.today + rand(1..3),
      end_date: Date.today + rand(4..6)
    )
  end
end

testservice = Service.new(
  user: testuser,
  title: "for test",
  description: Faker::Quote.most_interesting_man_in_the_world,
  price: rand(100..500)
)

testurl = 'https://this-person-does-not-exist.com/en'
testdoc = Nokogiri::HTML(URI.open(testurl).read)
testsrc = testdoc.search('#avatar').first['src']
testphoto_url = "https://this-person-does-not-exist.com#{testsrc}"
testfile = URI.open(testphoto_url)
testservice.photos.attach(io: testfile, filename: 'user.png', content_type: 'image/png')
testservice.save

puts "created test service"

johnservice = Service.new(
  user: john,
  title: "for John test",
  description: Faker::Quote.most_interesting_man_in_the_world,
  price: rand(100..500)
)

testurl = 'https://this-person-does-not-exist.com/en'
testdoc = Nokogiri::HTML(URI.open(testurl).read)
testsrc = testdoc.search('#avatar').first['src']
testphoto_url = "https://this-person-does-not-exist.com#{testsrc}"
testfile = URI.open(testphoto_url)
johnservice.photos.attach(io: testfile, filename: 'user.png', content_type: 'image/png')
johnservice.save

puts "created John service"

Booking.create!(
  user: john,
  service:testservice,
  status: "pending",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: User.where.not(id: testservice.user).sample,
  service:testservice,
  status: "pending",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: User.where.not(id: testservice.user).sample,
  service:testservice,
  status: "rejected",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: User.where.not(id: testservice.user).sample,
  service:testservice,
  status: "accepted",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

  Booking.create!(
    user: testuser,
    service: Service.where.not(user_id: testuser).sample,
    status: "accepted",
    start_date: Date.today + rand(1..3),
    end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: testuser,
  service: Service.where.not(user_id: testuser).sample,
  status: "pending",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: testuser,
  service: johnservice,
  status: "pending",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: testuser,
  service: Service.where.not(user_id: testuser).sample,
  status: "rejected",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

Booking.create!(
  user: testuser,
  service: Service.where.not(user_id: testuser).sample,
  status: "completed",
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6)
)

puts "created #{Booking.count} bookings!"


doug = User.create(
  name: "Doug Berkley",
  interest: Faker::Hobby.activity,
  location: "Meguro,Tokyo",
  sex: "male",
  description: Faker::Quote.most_interesting_man_in_the_world,
  age: 30,
  email: "doug@email.com",
  password: "123456"
)


puts "created Doug"


dougservice = Service.new(
  user: doug,
  title: "Soul mate",
  description: Faker::Quote.most_interesting_man_in_the_world,
  price: 99
)


dougservice.photos.attach(io: File.open("./app/assets/images/doug/IMG_5519.jpg"), filename: 'user.png', content_type: 'image/png')
dougservice.save
dougservice.photos.attach(io: File.open("./app/assets/images/doug/IMG_5520.jpg"), filename: 'user.png', content_type: 'image/png')
dougservice.save
dougservice.photos.attach(io: File.open("./app/assets/images/doug/IMG_5521.jpg"), filename: 'user.png', content_type: 'image/png')
dougservice.save
dougservice.photos.attach(io: File.open("./app/assets/images/doug/IMG_5522.jpg"), filename: 'user.png', content_type: 'image/png')
dougservice.save
dougservice.photos.attach(io: File.open("./app/assets/images/doug/IMG_5523.jpg"), filename: 'user.png', content_type: 'image/png')
dougservice.save


puts "created Doug service"

5.times do
Review.create!(
  rating: rand(3..5),
  comment: Faker::Restaurant.review,
  user: User.where.not(id: doug).sample,
  service: dougservice
  )
end

  puts "created Doug review"

  gui = User.create(
    name: "Gui",
    interest: Faker::Hobby.activity,
    location: "Meguro,Tokyo",
    sex: "male",
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: 20,
    email: "gui@email.com",
    password: "123456"
  )


  puts "created Gui"


    guiservice = Service.new(
    user: gui,
    title: "Soul mate",
    description: Faker::Quote.most_interesting_man_in_the_world,
    price: 98
  )


  guiservice.photos.attach(io: File.open("./app/assets/images/doug/91a29db5-b76f-4fa2-92b5-e7c8be4f3914.jpg"), filename: 'user.png', content_type: 'image/png')
  guiservice.save


  puts "created Gui service"

  5.times do
  Review.create!(
    rating: rand(3..5),
    comment: Faker::Restaurant.review,
    user: User.where.not(id: gui).sample,
    service: guiservice
    )
  end
