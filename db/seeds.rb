puts "Destroying all users..."
# User.destroy_all

puts "Destroying all pokemons..."
# Pokemon.destroy_all

puts "Creating user...."
user1 = User.create(email: "user@admin.com", password: "123456", password_confirmation: "123456")

puts "Creating pokemons...."
Pokemon.create!(user: user1, name: "Pikachu", overview: "Best friend", photo_url: "https://img.pokemondb.net/artwork/large/pikachu.jpg")
Pokemon.create!(user: user1, name: "Charmander", overview: "Great fighter", photo_url: "https://img.pokemondb.net/artwork/large/charmander.jpg")
user2 = User.create(email: "test@test.com", password: "123456", password_confirmation: "123456")
Pokemon.create!(user: user2, name: "Bulbasaur", overview: "Bulbasaur are small, amphibian and plant Pokémon that move on all four legs. They have blue-green bodies with darker blue-green spots. The seed on a Bulbasaur's back is planted at birth and then sprouts and grows along with it.", photo_url: "https://img.pokemondb.net/artwork/large/bulbasaur.jpg")
Pokemon.create!(user: user2, name: "Squirtle", overview: "quirtle is a small, light-blue Pokémon with an appearance similar to a turtle. With its aerodynamic shape and grooved surface, Squirtle's shell helps it wade through the water very quickly. It also offers protection in battle.", photo_url: "https://img.pokemondb.net/artwork/large/squirtle.jpg")
# user3 = User.create(email: "user@test.com", password: "123456", password_confirmation: "123456")
# Pokemon.create!(user: user3, name: "Jigglypuff", overview: "Jigglypuff is a round, pink ball with pointed ears and large, blue eyes. It has rubbery, balloon-like skin and small, stubby arms and somewhat long feet", photo_url: "https://img.pokemondb.net/artwork/large/jigglypuff.jpg")
# Pokemon.create!(user: user3, name: "Meowth", overview: "Meowth is a small, feline Pokémon with cream-colored fur and a distinct coin-like charm on its forehead. Its ears are black with brown insides, and they are large with tufts of fur at the base.", photo_url: "https://img.pokemondb.net/artwork/large/meowth.jpg")
# Pokemon.create!(user: user3, name: "Psyduck", overview: "Psyduck is a yellow Pokémon resembling a duck or bipedal platypus. On top of its head are three thick strands of black fur. It has a wide, flat, cream-colored beak and vacant eyes.", photo_url: "https://img.pokemondb.net/artwork/large/psyduck.jpg")
# Pokemon.create!(user: user3, name: "Mewtwo", overview: "Mewtwo is a Pokémon created by science. It is a bipedal, humanoid creature with some feline features. It is primarily gray with a long, purple tail.", photo_url: "https://img.pokemondb.net/artwork/large/mewtwo.jpg")
# Pokemon.create!(user: user3, name: "Charizard", overview: "Charizard is a draconic, bipedal Pokémon. It is primarily orange with a cream underside from the chest to the tip of its tail, which burns with a sizable flame.", photo_url: "https://img.pokemondb.net/artwork/large/charizard.jpg")
# Pokemon.create!(user: user3, name: "Blastoise", overview: "Blastoise is a large, bipedal turtle-like Pokémon. Its body is dark blue and is mostly hidden by its tough, brown shell. This shell has a pale yellow underside and a white ridge encircling its arms and separating the upper and lower halves.", photo_url: "https://img.pokemondb.net/artwork/large/blastoise.jpg")
# Pokemon.create!(user: user3, name: "Venusaur", overview: "Venusaur is a squat, quadruped Pokémon with bumpy, blue-green skin. It has small, circular red eyes, a short, blunt snout, and a wide mouth with two pointed teeth in the upper jaw and four in the lower jaw.", photo_url: "https://img.pokemondb.net/artwork/large/venusaur.jpg")
