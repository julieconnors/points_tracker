User.create(name: "Julie", username: "jules", password: "jules123")

Horse.create(name: "Lucador", user_id: 1)
Horse.create(name: "Cosmic", user_id: 1)

Horseshow.create(name: "WIHS", location: "DC")
Horseshow.create(name: "The National", location: "KY")

Prize.create(point_total: 1000, date: "10/14/19", horse_id: 1, horseshow_id: 1, user_id: 1)
Prize.create(point_total: 500, date: "11/1/19", horse_id: 1, horseshow_id: 2, user_id: 1)
Prize.create(point_total: 800, date: "10/14/19", horse_id: 2, horseshow_id: 1, user_id: 1)
Prize.create(point_total: 600, date: "11/1/19", horse_id: 2, horseshow_id: 2, user_id: 1)
