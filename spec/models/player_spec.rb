require "spec_helper"
require 'shoulda/matchers'

describe Player, type: :model do
  it { should belong_to :game }
  it { should have_many(:moves) }

  it { should validate_presence_of :game_id }
  it { should validate_presence_of :name }

end

