User.create(name: "Julie", username: "jules", password: "jules123")

Horse.create(name: "Lucador", user_id: 1)
Horse.create(name: "Cosmic", user_id: 1)

Horseshow.create(name: "WIHS", location: "DC", date: "2019-10-25",)
Horseshow.create(name: "The National", location: "KY", date: "2019-11-1",)

Prize.create(point_total: 1000, horse_id: 1, horseshow_id: 1, user_id: 1)
Prize.create(point_total: 500,  horse_id: 1, horseshow_id: 2, user_id: 1)
Prize.create(point_total: 800, horse_id: 2, horseshow_id: 1, user_id: 1)
Prize.create(point_total: 600, horse_id: 2, horseshow_id: 2, user_id: 1)
