class Artist < ActiveRecord::Base
  default_scope { order('name asc') }
  has_many :song
end
