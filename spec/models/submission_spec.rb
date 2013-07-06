require 'spec_helper'

describe Submission do

  describe "#initialize" do
    it { should belong_to(:user) }
    it { should belong_to(:survey) }
    it { should have_many(:responses) }
    it { should accept_nested_attributes_for :responses }

    it { should allow_mass_assignment_of(:survey) }
    it { should allow_mass_assignment_of(:user) }
    it { should allow_mass_assignment_of(:responses_attributes) }

    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:survey) }

  end

end
