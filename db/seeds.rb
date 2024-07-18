require "json"
require "open-uri"

puts "Destroying all users..."
User.destroy_all

puts "Destroying all pokemons..."
Pokemon.destroy_all

puts "Creating user...."

user1 = User.create(email: "user@admin.com", name: "John", password: "123456", password_confirmation: "123456")
user2 = User.create(email: "user2@admin.com", name: "Smith", password: "123456", password_confirmation: "123456")
user3 = User.create(email: "user3@admin.com", name: "Mary", password: "123456", password_confirmation: "123456")
user4 = User.create(email: "user4@admin.com", name: "Yannan", password: "123456", password_confirmation: "123456")

users = [user1, user2, user3, user4]

random_user = users.sample

puts "Creating pokemons...."

# Querying for all pokemons

pokemon_name_url = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
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
  random_price = rand(100..200)

  #Get a random address
  street_address = [
    # Victoria
    "Collins St, Melbourne, Victoria",
    "Chapel St, South Yarra, Victoria",
    "High St, Prahran, Victoria",
    "Glenferrie Rd, Hawthorn, Victoria",
    "Burwood Rd, Hawthorn East, Victoria",
    "Whitehorse Rd, Box Hill, Victoria",
    "Maroondah Hwy, Ringwood, Victoria",
    "Nepean Hwy, Frankston, Victoria",
    "Springvale Rd, Glen Waverley, Victoria",
    "Lonsdale St, Dandenong, Victoria",
    # New South Wales
    "George St, Sydney, New South Wales",
    "Crown St, Surry Hills, New South Wales",
    "King St, Newtown, New South Wales",
    "Darling St, Balmain, New South Wales",
    "Victoria Rd, Parramatta, New South Wales",
    "Campbell St, Liverpool, New South Wales",
    "Hunter St, Newcastle, New South Wales",
    "Keira St, Wollongong, New South Wales",
    "Victoria St, Chatswood, New South Wales",
    "Pacific Hwy, Coffs Harbour, New South Wales",
    # Queensland
    "Queen St, Brisbane, Queensland",
    "Stanley St, South Brisbane, Queensland",
    "Cavendish Rd, Coorparoo, Queensland",
    "Logan Rd, Woolloongabba, Queensland",
    "Boundary St, West End, Queensland",
    "Victoria St, Toowoomba, Queensland",
    "James St, Fortitude Valley, Queensland",
    "Abbott St, Cairns, Queensland",
    "Bundall Rd, Bundall, Queensland",
    "Victoria St, Mackay, Queensland",
    # Western Australia
    "St Georges Terrace, Perth, Western Australia",
    "Beaufort St, Highgate, Western Australia",
    "Oxford St, Leederville, Western Australia",
    "Cambridge St, West Leederville, Western Australia",
    "Railway Parade, West Leederville, Western Australia",
    "Stirling Hwy, Nedlands, Western Australia",
    "Canning Hwy, Como, Western Australia",
    "Albany Hwy, Victoria Park, Western Australia",
    "Rockingham Rd, Rockingham, Western Australia",
    "Hannan St, Kalgoorlie, Western Australia",
    # South Australia
    "King William St, Adelaide, South Australia",
    "Rundle St, Adelaide, South Australia",
    "O'Connell St, North Adelaide, South Australia",
    "Jetty Rd, Glenelg, South Australia",
    "Brighton Rd, Brighton, South Australia",
    "Main North Rd, Prospect, South Australia",
    "Grand Junction Rd, Port Adelaide, South Australia",
    "Port Rd, Hindmarsh, South Australia",
    "Magill Rd, Norwood, South Australia",
    "Henley Beach Rd, Mile End, South Australia",
    # Tasmania
    "Elizabeth St, Hobart, Tasmania",
    "Macquarie St, Hobart, Tasmania",
    "Liverpool St, Hobart, Tasmania",
    "Main Rd, Moonah, Tasmania",
    "Charles St, Launceston, Tasmania",
    "Invermay Rd, Invermay, Tasmania",
    "Mount St, Burnie, Tasmania",
    "William St, Devonport, Tasmania",
    "Victoria St, Ulverstone, Tasmania",
    "Main St, Huonville, Tasmania",
    # Northern Territory
    "Mitchell St, Darwin, Northern Territory",
    "Smith St, Darwin, Northern Territory",
    "Cavenagh St, Darwin, Northern Territory",
    "Knuckey St, Darwin, Northern Territory",
    "Stuart Hwy, Alice Springs, Northern Territory",
    "Bath St, Alice Springs, Northern Territory",
    "Gap Rd, Alice Springs, Northern Territory",
    "Leichhardt Terrace, Alice Springs, Northern Territory",
    "Smith St, Tennant Creek, Northern Territory",
    "Paterson St, Tennant Creek, Northern Territory",
    # Australian Capital Territory
    "Northbourne Ave, Canberra, ACT",
    "Bunda St, Canberra, ACT",
    "London Circuit, Canberra, ACT",
    "Constitution Ave, Canberra, ACT",
    "Marcus Clarke St, Canberra, ACT",
    "Bowes St, Woden, ACT",
    "Hibberson St, Gungahlin, ACT",
    "Drakeford Dr, Tuggeranong, ACT",
    "Gungahlin Dr, Gungahlin, ACT",
    "Bowman St, Macquarie, ACT"
  ]

  random_street = street_address.sample

  # Create Pokemon record
  pokemon = Pokemon.new(
    user: random_user,
    name: pokemon_name.capitalize,
    overview: pokemon_description,
    price: random_price,
    address: random_street
  )

  pokemon_image_file = URI.open(pokemon_image_url)
  pokemon.photos.attach(io: pokemon_image_file, filename: "#{pokemon_name}_image1.png", content_type: 'image/png')

  pokemon_image_2_file = URI.open(pokemon_image2_url)
  pokemon.photos.attach(io: pokemon_image_2_file, filename: "#{pokemon_name}_image2.png", content_type: 'image/png')

  pokemon.save!
  puts "Created Pokemon: #{pokemon_name.capitalize}"
end
