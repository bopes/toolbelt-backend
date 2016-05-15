
User.delete_all
Tool.delete_all

c = User.create(first_name: "Charlie", last_name: "Lee", email:"clcblee@gmail.com", street_address_1: "740 Berkeley Ave", city: "Charlotte", state: "NC", rating:"4", password: "password")
p1 = User.create(first_name: "Phil", last_name: "Barnett", email:"p@p.com", street_address_1: "633 Folsom St", city: "San Francisco", state: "CA", rating:"4", password: "password")
p2 = User.create(first_name: "Philip", last_name: "B", email:"pp@pp.com", street_address_1: "425 Market St", city: "San Francisco", state: "CA", rating:"4", password: "password")

Tool.create(user: c, title:"drill")
Tool.create(user: c, title:"saw")
Tool.create(user: p1, title:"drill")
Tool.create(user: p1, title:"saw")
Tool.create(user: p1, title:"sander")
Tool.create(user: p2, title:"drill")
Tool.create(user: p2, title:"saw")
Tool.create(user: p2, title:"sander")