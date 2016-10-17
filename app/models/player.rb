class Player < ActiveRecord::Base
  belongs_to :game
  has_many :moves

  validates :game_id, presence: true
  validates :name, presence: true

end

