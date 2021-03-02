# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(email: "clh@hotmail.de", password: "123456")
# StrollSetting.create(user: User.last)
# Walk.create(user: User.last, stroll_setting: StrollSetting.last)
# StartingLocation.create(address: "Brunnenstrasse 13, 10119 Berlin", walk: Walk.last)
# EndingLocation.create(address: "Alexanderplatz, Berlin", walk: Walk.last)

require 'json'
require 'open-uri'

url = "https://vberlindev.blob.core.windows.net/data/content_offline_stage_en.json"

locations_serialized = URI.open(url).read

list = JSON.parse(locations_serialized)

locations = list['pois']

# name = site['headline']
# address = site['address']
# latitude = site['coordinates']['latitude']
# longitude = site['coordinates']['longitude']
# info = site['endText']
# intro = site['teasertext']
# photo_caption = site['gallery'].first['title']
# photo_url =  site['gallery'].first['sourceUrl']
# facts = site['facts']
# puts site['headline']
# puts site['address']
# puts site['coordinates']
# puts site["teasertext"]
# puts site['mainText']
# puts site['endText']
# puts site['gallery'].first['title']
# puts site['gallery'].first['sourceUrl']
# puts site['facts']
# puts site['teasertext']

locations.each do |location|
  Location.create!(
    name: location['headline'],
    address: location['address'],
    latitude: location['coordinates']['latitude'],
    longitude: location['coordinates']['longitude'],
    info: location['endText'],
    intro: location['teasertext'],
    content: location['mainText'],
    photo_caption: location['gallery'].first['title'],
    photo_url: location['gallery'].first['sourceUrl'],
    facts: facts = location['facts'],
    sources: "https://www.visitberlin.de",
    cost: 0,
    significance: 1,
    lang: "en",
    category: "history"
  )
  puts location['headline']
  puts Location.last
end
