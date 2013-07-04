require 'spec_helper'

describe Survey do

  describe "#initialize" do

    it { should belong_to(:category) }
    it { should have_many(:questions) }
    it { should validate_presence_of(:title) }

    describe "#should be able to create three questions, based on user input" do
      let(:survey) { build(:survey) }
      expect survey.questions.size to eq(3)
    end

    

  end


end
