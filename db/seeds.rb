require "json"
require "open-uri"

puts "Destroying all users..."
User.destroy_all

puts "Destroying all pokemons..."
Pokemon.destroy_all

puts "Creating user...."
user1 = User.create(email: "user@admin.com", password: "123456", password_confirmation: "123456")

puts "Creating pokemons...."

pokemon_name_url = "https://pokeapi.co/api/v2/pokemon?limit=150&offset=0"
user_serialized = URI.open(pokemon_name_url).read
user = JSON.parse(user_serialized)

pokemon_hash = user["results"]

pokemon_hash.each do |pokemon|
  pokemon_url = pokemon["url"]

  # Fetching Pokemon details
  pokemon_data_serialized = URI.open(pokemon_url).read
  pokemon_data = JSON.parse(pokemon_data_serialized)

  pokemon_name = pokemon_data["name"]
  pokemon_image = pokemon_data["sprites"]["other"]["dream_world"]["front_default"]
  pokemon_image_option = pokemon_data["sprites"]["other"]["official-artwork"]["front_default"]
  # pokemon_image_option_2 = description["sprites"]["other"]["home"]["front_shiny"] # Option for a third image

  # Fetching Pokemon description
  pokemon_species_url = "https://pokeapi.co/api/v2/pokemon-species/#{pokemon_name}"
  pokemon_species_serialized = URI.open(pokemon_species_url).read
  pokemon_species_data = JSON.parse(pokemon_species_serialized)

  pokemon_description = pokemon_species_data["flavor_text_entries"].find { |entry| entry["language"]["name"] == "en" }["flavor_text"]
  # Generating random price
  random_price = rand(100..200).to_f

  # Create Pokemon record
  Pokemon.create!(
    user: user1,
    name: pokemon_name.capitalize,
    overview: pokemon_description,
    photo_url: pokemon_image,
    photo2_url: pokemon_image_option,
    price: random_price
  )

  # puts "Created Pokemon: #{pokemon_name.capitalize}"
end
