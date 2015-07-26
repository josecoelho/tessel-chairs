# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


(1..10).each do |line|
  chair_group = ChairGroup.create(name: line.to_s)
  ["A","B","C","D","E","F","G","H","I","J","K","L"].each do |seat|
    Chair.create(name: seat, chair_group: chair_group)
  end
end