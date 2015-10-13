# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Game.create!(name: 'Settlers of Catan')
Game.create!(name: 'Carcassonne')
Game.create!(name: 'Ticket to Ride')
Game.create!(name: 'Stone Age')
Game.create!(name: 'Dominion')
Game.create!(name: 'Suburbia')
Game.create!(name: 'Tikal')
Game.create!(name: 'Terra Mystica')
Game.create!(name: 'Puerto Rico')
Game.create!(name: '7 Wonders')

Borrower.create!(first_name: 'George', last_name: 'Washington')
Borrower.create!(first_name: 'John', last_name: 'Adams')
Borrower.create!(first_name: 'Thomas', last_name: 'Jefferson')