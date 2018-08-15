require('pg')
require_relative('artist')
require_relative( '../db/sql_runner' )


class Album

  attr_reader :id
  attr_accessor :name, :genre

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @genre = info['genre']
  end

  def save()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "INSERT INTO albums
    (name, genre)
    VALUES
    ($1, $2) RETURNING *"
    values = [@name, @genre]
    # db.prepare("save", sql)
    # @id = db.exec_prepared("save", values)[0]["id"].to_i
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
    # db.close()
  end

  def Album.all()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "SELECT * FROM albums"
    # db.prepare("all", sql)
    albums = SqlRunner.run(sql)
    # db.close()
    return albums.map {|album| Album.new(album)}
  end

  # def Album.find_by_artist(artist)
  #   db = PG.connect({ dbname: "music_library", host: "localhost"})
  #   sql = "SELECT * FROM albums WHERE "
  # end

  def edit()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "UPDATE albums
    SET (name, genre) = ($1, $2)
    WHERE id = $3"
    values = [@name, @genre, @id]
    # db.prepare("edit", sql)
    SqlRunner.run(sql, values)
    # db.close()
  end

  def Album.find_by_id(id)
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    # db.prepare("find_by_id", sql)
    result = SqlRunner.run( sql, values)
    album = self.new(result.first)
    return album
    # db.close()
    # if result.count > 0
    #   return result[0]
    # else
    #   return nil
    # end
  end

  def Album.delete()
    db = PG.connect({ dbname: "music_library", host: "localhost"})
    # sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    # db.prepare("delete_one", sql)
    SqlRunner.run(sql, values)
    # db.close()
  end

  def Album.delete_all()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "DELETE FROM albums"
    # db.prepare("delete_all", sql)
    # db.exec_prepared("delete_all")
    SqlRunner.run(sql)
    # db.close()
  end
end
