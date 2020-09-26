User.create(username: "jules", password: "jules123")

Horse.create(name: "Lucador", point_total: 0, user_id: 1)
Horse.create(name: "Cosmic", point_total: 0, user_id: 1)

HorseShow.create(name: "WIHS", location: "DC")
HorseShow.create(name: "The National", location: "KY")

Point.create(total: 1000, horse_id: 1, horse_show_id: 1)
Point.create(total: 500, horse_id: 1, horse_show_id: 2)
Point.create(total: 800, horse_id: 2, horse_show_id: 1)
Point.create(total: 600, horse_id: 2, horse_show_id: 2)
