class Song < ActiveRecord::Base
  default_scope { order('title asc') }
  belongs_to :artist
end
