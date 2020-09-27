User.create(username: "jules", password: "jules123")

Horse.create(name: "Lucador", user_id: 1)
Horse.create(name: "Cosmic", user_id: 1)

HorseShow.create(name: "WIHS", location: "DC")
HorseShow.create(name: "The National", location: "KY")

Prize.create(point_total: 1000, horse_id: 1, horse_show_id: 1)
Prize.create(point_total: 500, horse_id: 1, horse_show_id: 2)
Prize.create(point_total: 800, horse_id: 2, horse_show_id: 1)
Prize.create(point_total: 600, horse_id: 2, horse_show_id: 2)
