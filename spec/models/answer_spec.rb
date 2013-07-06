require 'spec_helper'

describe Answer do

  describe "#initialize" do

    it { should belong_to(:question) }
    it { should have_many(:responses) }
    it { should allow_mass_assignment_of(:weight) }
    it { should allow_mass_assignment_of(:text) }

  end

end
