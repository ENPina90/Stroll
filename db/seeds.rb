# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "clh@hotmail.de", password: "123456")
StrollSetting.create(user: User.last)
Walk.create(user: User.last, stroll_setting: StrollSetting.last)
StartingLocation.create(address: "Brunnenstrasse 13, 10119 Berlin", walk: Walk.last)
EndingLocation.create(address: "Alexanderplatz, Berlin", walk: Walk.last)
