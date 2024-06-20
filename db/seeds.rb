# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Book.destroy_all

Book.create!([{
  title: "Pride and Prejudice",
  author: "J. Austen",
  publication_date: "12-12-1813",
  genre: "novel",
  status: true,
  quantity: 5
},{
  title: "American Notes",
  author: "C. Dickens",
  publication_date: "12-12-1842",
  genre: "novel",
  status: true,
  quantity: 5
},{
  title: "Coral Reefs",
  author: "J. Austen",
  publication_date: "12-11-1842",
  genre: "novel",
  status: true,
  quantity: 5
}])

User.create!([{
  email:"abc@xyz.com",
  password: "123",
  password_confirmation: "123",
  role: "admin"
},{
  email: "a@b.com",
  password: "123",
  password_confirmation: "123",
  role: "librarian"
},{
  email: "c@d.com",
  password: "123",
  password_confirmation: "123",
  role: "member"
}])

p "Created #{Book.count} books"
p "Created #{User.count} users"
