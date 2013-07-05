require 'spec_helper'

describe Question do

  describe "#initialize" do

    it { should belong_to(:survey) }
    it { should have_many(:answers) }
    it { should accept_nested_attributes_for :answers }
    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:qtype) }
    it { should allow_mass_assignment_of(:answers_attributes) }

  end  

end
