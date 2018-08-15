require('pry-byebug')
require_relative('models/artist')
require_relative('models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "artist_name" => "Metallica"
  })

artist2 = Artist.new({
  "artist_name" => "Stromae"
  })

artist3 = Artist.new({
  "artist_name" => "Little Dragon"
  })

artist4 = Artist.new({
  "artist_name" => "Queen"
  })

  artist1.save
  artist2.save
  artist3.save
  artist4.save
  
album1 = Album.new({
  "name" =>"Album1",
  "genre" => "Rock"
  })

album2 = Album.new({
  "name" =>"Album2",
  "genre" => "Pop"
  })

album3 = Album.new({
  "name" =>"Album2",
  "genre" => "Jazz"
  })

  album1.save
  album2.save
  album3.save

binding.pry
nil
