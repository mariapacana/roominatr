require 'spec_helper'

describe Survey do

  describe "#initialize" do

    it { should belong_to(:category) }
    it { should have_many(:submissions) }
    it { should have_many(:questions) }
    it { should accept_nested_attributes_for :questions }

    it { should validate_presence_of(:title) }

    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:questions_attributes) }
    it { should allow_mass_assignment_of(:category) }

  end

  describe "creating a survey" do
    let(:survey) { create(:survey_with_questions) }

    it "creates 'how important' to you question by default" do
      survey.questions.any? { |q|
        q.body.include? "How important is this"
      }.should be true
    end

    it  "creates 'how would you like your roommate' question by default" do
      survey.questions.any? { |q|
        q.body.include? "How would you like your roommate to answer?"
      }.should be true
    end

    it "has 3 questions of types 'me', 'roommate', and 'importance'" do
      survey.questions.collect {|q|
        q.qtype }.should eq(["roommate", "importance", "me"])
    end

    xit "roommate question has same answer text as first question" do
      # p survey.questions.find_by_qtype("roommate").answers
      # p survey.questions.find_by_qtype("me").answers
      # p survey.questions.find_by_qtype("importance").answers
    end

    it "has a question of type importance with answers 'not', 'kinda', and 'very'" do
      q_importance = survey.questions.find_by_qtype("importance")
      q_importance.answers.collect {|answer|
        answer.text }.should eq(["Not", "Kinda", "Very"])
    end
  end

end
