100.times do |t|
  user = User.create(email: "test#{t}@example.com", password: 'password')
  user.books.create(title: "test Title#{t}", content: "test Content #{t}")
end
