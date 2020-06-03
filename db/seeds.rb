# User.create(name: "tester01")
# User.create(id: 1) 
User.create(name: "aaa", email: "aaa@gmail.com", password_digest: "aaaaaa")
5.times do |i|
    Label.create!(name: "sample#{i + 1}")
end

User.create!(name:  "admin",
             email: "admin@example.jp",
             password:  "11111111",
             password_confirmation: "11111111",
             admin: true)

