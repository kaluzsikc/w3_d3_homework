require('pg')
require_relative( '../db/sql_runner' )

class Artist

  attr_reader :id
  attr_accessor :artist_name

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @artist_name = info['artist_name']
  end

  def save()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "INSERT INTO artists
    (artist_name)
    VALUES
    ($1) RETURNING *"
    values = [@artist_name]
    # db.prepare("save", sql)
    @id = SqlRunner.run( sql, values)[0]["id"].to_i
    # db.exec_prepared("save", values)[0]["id"].to_i
    # db.close()
  end

  def Artist.all()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "SELECT * FROM artists"
    # db.prepare("all", sql)
    artists = SqlRunner.run(sql)
    # artists = db.exec_prepared("all")
    # db.close()
    return artists.map {|artist| Artist.new(artist)}
  end

  def find_by_album()
    db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "SELECT * FROM albums WHERE id = $1"
    value = [@id]
    db.prepare("find_by_album", sql)
    result = db.exec_prepared("find_by_album", value)
    db.close()
    return result.map {|album| Album.new(album)}
  end

  # def find_by_album()
  #   sql = "SELECT * FROM albums WHERE id = $1"
  #   value = [@id]
  #   result = SqlRunner.run(sql, value)
  #   return result.map {|album| Album.new(album)}
  # end

  def edit()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "UPDATE artists
    SET artist_name = $1
    WHERE id = $2"
    values = [@artist_name, @id]
    # db.prepare("edit", sql)
    # db.exec_prepared("edit", values)
    # db.close()
    SqlRunner.run( sql, values)
  end

  def Artist.find_by_id(id)
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    # db.prepare("find_by_id", sql)
    # result = db.exec_prepared("find_by_id", values)
    result = SqlRunner.run(sql, values)
    artist = self.new(result.first)
    return artist
    # db.close()
    # if result.count > 0
    #   return result[0]
    # else
    #   return nil
    # end
  end

  def delete()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    # db.prepare("delete_one", sql)
    # db.exec_prepared("delete_one", values)
    # db.close()
    SqlRunner.run(sql , values)
  end

  def Artist.delete_all()
    # db = PG.connect({ dbname: "music_library", host: "localhost"})
    sql = "DELETE FROM artists"
    # db.prepare("delete_all", sql)
    # db.exec_prepared("delete_all")
    # db.close()
    SqlRunner.run(sql)
  end
end
