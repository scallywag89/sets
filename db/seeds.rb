require 'faker'


if Rails.env.development?
  puts "Clearing development database..."
  Track.destroy_all
  Album.destroy_all
  Stack.destroy_all
  Setlist.destroy_all
  User.destroy_all
  StackAlbum.destroy_all
  SetTrack.destroy_all
  puts "-------------------------------------------------------"
  puts "No more Database!"
end

puts "Generating  Albums (with tracks)..."
6.times do
  album = Album.create(
    title: Faker::Music.album,
    artist: Faker::Music.band,
    year: (1970..2012).to_a.sample
  )
  8.times do
    Track.create(
    name: Faker::Music::RockBand.song,
    album_id: album.id
    )
  end
  puts "Added album ##{album.id}: #{album.title}"
end

puts "-------------------------------------------------------"
puts "Generating Users..."

5.times do
  user = User.create(
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nickname: Faker::TvShows::StarTrek.character
  )
  user.update(email: "#{user.first_name}.#{user.last_name}@sets.com")
  puts "Added User ##{user.id}: #{user.nickname}"
end

puts "-------------------------------------------------------"
puts "Populating Stacks..."

Stack.all.each do |stack|
  5.times do
    StackAlbum.create(
      stack_id: stack.id,
      album_id: Album.all.sample.id
    )
  end
end


puts "-------------------------------------------------------"
puts "Generating User Setlists..."

User.all.each do |user|
  3.times do
   set = Setlist.create(
      name: "#{Faker::Lorem.word} list",
      user_id: user.id
    )
    3.times do
      SetTrack.create(
        track_id: Track.all.sample.id,
        setlist_id: set.id
      )
    end
  end
end
puts "Database generated, creating ADMIN.."

User.create(
  password: "admin1",
  first_name: "admin",
  last_name: "jens",
  nickname: "admin"
)
puts "Done!"
