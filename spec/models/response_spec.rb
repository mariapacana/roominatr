require 'spec_helper'

describe Response do

  describe "#initialize" do
    it { should belong_to(:submission) }
    it { should belong_to(:question) }
    it { should belong_to(:answer) }
    it { should allow_mass_assignment_of(:question_id) }
    it { should allow_mass_assignment_of(:answer_id) }

    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:submission) }
  end
end
