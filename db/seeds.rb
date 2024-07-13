require "json"
require "open-uri"

puts "Destroying all users..."
User.destroy_all

puts "Destroying all pokemons..."
Pokemon.destroy_all

puts "Creating user...."
user1 = User.create(email: "user@admin.com", password: "123456", password_confirmation: "123456")

puts "Creating pokemons...."

# Querying for all pokemons

pokemon_name_url = "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0"
user_serialized = URI.open(pokemon_name_url).read
user = JSON.parse(user_serialized)

pokemon_hash = user["results"]

# Iterating over each pokemon
pokemon_hash.each do |pokemon|
  pokemon_url = pokemon["url"]

  # Fetching Pokemon details
  pokemon_data_serialized = URI.open(pokemon_url).read
  pokemon_data = JSON.parse(pokemon_data_serialized)

  # Fetching Pokemon images
  pokemon_name = pokemon_data["name"]
  pokemon_image_url = pokemon_data["sprites"]["other"]["dream_world"]["front_default"]
  pokemon_image2_url = pokemon_data["sprites"]["other"]["official-artwork"]["front_default"]

  # Fetching Pokemon description
  pokemon_species_url = "https://pokeapi.co/api/v2/pokemon-species/#{pokemon_name}"
  pokemon_species_serialized = URI.open(pokemon_species_url).read
  pokemon_species_data = JSON.parse(pokemon_species_serialized)

  pokemon_description = pokemon_species_data["flavor_text_entries"].find { |entry| entry["language"]["name"] == "en" }["flavor_text"]
  # Generating random price
  random_price = rand(100..200).to_f

  # Create Pokemon record
  pokemon = Pokemon.new(
    user: user1,
    name: pokemon_name.capitalize,
    overview: pokemon_description,
    price: random_price
  )

  pokemon_image_file = URI.open(pokemon_image_url)
  pokemon.photos.attach(io: pokemon_image_file, filename: "#{pokemon_name}_image1.png", content_type: 'image/png')

  pokemon_image_2_file = URI.open(pokemon_image2_url)
  pokemon.photos.attach(io: pokemon_image_2_file, filename: "#{pokemon_name}_image2.png", content_type: 'image/png')

  pokemon.save!
  puts "Created Pokemon: #{pokemon_name.capitalize}"
end
