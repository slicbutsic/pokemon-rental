puts "Destroying all users..."
User.destroy_all

puts "Destroying all pokemons..."
Pokemon.destroy_all

puts "Creating user...."
user1 = User.create(email: "user@admin.com", password: "123456", password_confirmation: "123456")

puts "Creating pokemons...."
Pokemon.create!(user: user1, name: "Pikachu", overview: "Best friend", photo_url: "https://img.pokemondb.net/artwork/large/pikachu.jpg")
Pokemon.create!(user: user1, name: "Charmander", overview: "Great fighter", photo_url: "https://img.pokemondb.net/artwork/large/charmander.jpg")
