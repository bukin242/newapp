class Artist < ActiveRecord::Base
  default_scope { order('name asc') }
  has_many :songs

  def songs_top
    sql = <<-SQL
      with suitable_songs as (
        select songs.artist_id, downloads.song_id as song_id, count(downloads.song_id) as count from songs
          join downloads on downloads.song_id = songs.id
          group by songs.artist_id, downloads.song_id
          having songs.artist_id = #{id}
      )
      select * from songs
        join suitable_songs on songs.id = suitable_songs.song_id
       order by suitable_songs.count desc
    SQL

    Song.find_by_sql(sql)
  end

  def self.top
    sql = <<-SQL
      with suitable_songs as (
        select songs.artist_id, downloads.song_id as song_id, count(downloads.song_id) as count from songs
          join downloads on downloads.song_id = songs.id
          group by songs.artist_id, downloads.song_id
      )
      , suitable_artists as (
        select suitable_songs.artist_id, sum(suitable_songs.count) as count from artists
          join suitable_songs on artists.id = suitable_songs.artist_id
          group by suitable_songs.artist_id
      )
      select * from artists
        join suitable_artists on artists.id = suitable_artists.artist_id
       order by suitable_artists.count desc
    SQL

    Artist.find_by_sql(sql)
  end
end
