require "spec_helper"
require 'shoulda/matchers'

describe Game, type: :model do
  it { should have_many(:players) }
  it { should have_many(:moves) }
end
