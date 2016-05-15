
User.delete_all
Tool.delete_all

User.create(first_name: "Charlie", last_name: "Lee", email:"clcblee@gmail.com", street_address_1: "740 Berkeley Ave", city: "Charlotte", state: "NC", rating:"4", password: "password")
User.create(first_name: "Phil", last_name: "Barnett", email:"p@p.com", street_address_1: "633 Folsom St", city: "San Francisco", state: "CA", rating:"4", password: "password")
User.create(first_name: "Philip", last_name: "B", email:"pp@pp.com", street_address_1: "425 Market St", city: "San Francisco", state: "CA", rating:"4", password: "password")

Tool.create(user_id: 3, title:"drill")
Tool.create(user_id: 3, title:"saw")
Tool.create(user_id: 4, title:"drill")
Tool.create(user_id: 4, title:"saw")
Tool.create(user_id: 4, title:"sander")
Tool.create(user_id: 5, title:"drill")
Tool.create(user_id: 5, title:"saw")
Tool.create(user_id: 5, title:"sander")