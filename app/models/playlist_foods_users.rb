class PlaylistFoodsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlistfood
end