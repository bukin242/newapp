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
end
