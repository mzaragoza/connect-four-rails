require "spec_helper"
require 'shoulda/matchers'

describe Move, type: :model do
  it { should belong_to :game }
  it { should belong_to :player }

  it { should validate_presence_of :game_id }
  it { should validate_presence_of :player_id }
  it { should validate_presence_of :row }
  it { should validate_presence_of :column }

  it { should validate_numericality_of(:row) }
  it { should_not allow_value(-1).for(:row) }

  it "returns the last row if there are none" do
    game = Game.create(rows: 10)
    get_row = Move.get_row({game_id: game.id, column: 6})
    expect(get_row).to eq 10
  end

  it "returns the one on top of the last selected row" do
    game = Game.create(rows: 10)
    get_row = Move.get_row({game_id: game.id, column: 6})
    Move.create( game_id: game.id, player_id: game.players.first.id, column: 6, row: get_row )
    get_row = Move.get_row({game_id: game.id, column: 6})
    expect(get_row).to eq 9
  end
end

