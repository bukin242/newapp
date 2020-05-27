class Song < ActiveRecord::Base
  default_scope { order('title asc') }
  belongs_to :artist

  def self.top(days, count)
    start_date = (DateTime.current - days.days).strftime('%Y-%m-%d %H:%M:%S')
    end_date = DateTime.current.strftime('%Y-%m-%d %H:%M:%S')

    sql = <<-SQL
      with suitable_songs as (
        select downloads.song_id as song_id, count(downloads.song_id) as count from songs
          join downloads on downloads.song_id = songs.id
         where downloads.created_at >= '#{start_date}' and downloads.created_at < '#{end_date}'
         group by downloads.song_id
      )
      select * from songs
        join suitable_songs on songs.id = suitable_songs.song_id
       order by suitable_songs.count desc
       limit #{count}
    SQL

    Song.find_by_sql(sql)
  end
end
