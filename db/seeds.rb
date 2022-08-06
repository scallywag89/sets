require 'faker'
@spotify = SpotifyService.new.authenticate

puts "Do you want to clear the database? [Y/N]"
response = STDIN.gets.chomp!
if response.upcase == "Y"
  puts "Clearing development database..."
  Track.destroy_all
  Album.destroy_all
  Setlist.destroy_all
  Stack.destroy_all
  User.destroy_all
  StackAlbum.destroy_all
  SetTrack.destroy_all
  puts "-------------------------------------------------------"
  puts "No more Database!"
end

puts "Do you want to seed the Database? [Y/N]"
response = STDIN.gets.chomp!
if response.upcase == "Y"
  puts "Generating Users..."
  puts "-------------------------------------------------------"
  prefix = ["DJ ", "Sounds Like ", "", "", "DJ "]
  16.times do
    user = User.new(
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    )
    user.update(
      nickname: "#{prefix.sample.chomp}#{[Faker::TvShows::StarTrek.character, user[:first_name], user[:last_name]].sample}",
      email: "#{user[:first_name]}.#{user[:last_name]}@sets.com"
    )
    user.save
    puts "Added User ##{user.id}: #{user.nickname}"
  end

  puts "-------------------------------------------------------"
  puts "Generating  Albums (with tracks)..."
    search_queries = ["SOUR", "Future Nostalgia", "Mansion Air", "Glass Animals", "Gorillaz", "Madonna", "Taylor Swift"]
    search_queries.each do |query|
      search = RSpotify::Album.search(query)
      search.each do |result|
        Album.create(
          spotify_id: result.id,
          artist: result.artists.first.name,
          title: result.name,
          year: result.release_date,
          cover_image_url: result.images.first["url"],
        )
        puts "#{result.name} added!"
      end
    end

    puts "-------------------------------------------------------"
    puts "Populating stacks, creating setlists, generating followers..."
    User.all.each do |user|
      rand(6..12).times do
        StackAlbum.create(
          stack_id: user.stack.id,
          album_id: Album.all.sample.id
        )
      end
      rand(2..5).times do
        Setlist.create(
          name: "#{Faker::Emotion.adjective} setlist",
          user_id: user.id
        )
      end
      array_of_users = User.where.not(id: user.id)
      rand(2..6).times do
        liked_user = array_of_users.sample
        Favorite.create(
          favoritable_type: "User",
          favoritable_id: liked_user.id,
          favoritor_type: "User",
          favoritor_id: user.id
        )
        array_of_users -= [liked_user]
      end
    end

    puts "-------------------------------------------------------"
    puts "Populating setlists..."
    Setlist.all.each do |setlist|
      rand(8..24).times do
        SetTrack.create(
          setlist_id: setlist.id,
          track_id: Track.all.sample.id
        )
      end
    end

    puts "-------------------------------------------------------"
    puts "Database seeded, all done!"
    puts "Would you like to create the default admin account? [Y/N]"
    response = STDIN.gets.chomp!
    if response.upcase == "Y"
      User.create(
        first_name: "admin",
        last_name: "sets",
        nickname: "ADMIN",
        email: "admin@sets.com",
        password: "admin1"
      )
    end
    puts "Bye-bye!"
end
