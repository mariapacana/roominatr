require 'spec_helper'

describe User do

  let(:user) { create(:user_with_submissions) }

  describe "#initialize" do

    describe "should have the correct associations" do
        it { should have_many(:submissions)}
        it { should have_many(:responses).through(:submissions)}
        it { should have_many(:answers).through(:responses)}
        it { should have_many(:category_scores)}
        it { should have_one(:house)}
        it { should have_one(:location)}
    end

    describe "should have the correct validations" do
        it { should validate_presence_of(:username) }
        it { should validate_uniqueness_of(:username) }
        it { should validate_presence_of(:email) }
        it { should validate_uniqueness_of(:email) }
        it { should allow_value('user@example.com').for(:email)}
        it { should validate_presence_of(:birthday) }
        it { should validate_presence_of(:gender) }
        it { should validate_presence_of(:location) }
        it { should allow_value(true).for(:has_house) }
        it { should allow_value(false).for(:has_house) }
        it { should_not allow_value(nil).for(:has_house) }
        it { should ensure_length_of(:summary).
            is_at_most(200).
            with_long_message(/should be less than 200 characters/)}
        it { should ensure_length_of(:best_roommate).
            is_at_most(300).
            with_long_message(/should be less than 300 characters/)}
        it { should ensure_length_of(:worst_roommate).
            is_at_most(300).
            with_long_message(/should be less than 300 characters/)}
        it { should validate_numericality_of(:rent_pref_min) }
        it { should validate_numericality_of(:rent_pref_max) }
    end

    describe "should accept nested attributes for" do
        it { should accept_nested_attributes_for(:location)}
    end

    describe "should allow mass assignment of various attributes" do
        it { should allow_mass_assignment_of(:username)}
        it { should allow_mass_assignment_of(:email)}
        it { should allow_mass_assignment_of(:password)}
        it { should allow_mass_assignment_of(:password_confirmation)}
        it { should allow_mass_assignment_of(:avatar)}
        it { should allow_mass_assignment_of(:birthday)}
        it { should allow_mass_assignment_of(:gender)}
        it { should allow_mass_assignment_of(:food_preferences)}
        it { should allow_mass_assignment_of(:summary)}
        it { should allow_mass_assignment_of(:best_roommate)}
        it { should allow_mass_assignment_of(:worst_roommate)}
        it { should allow_mass_assignment_of(:pets)}
        it { should allow_mass_assignment_of(:weekend_activity)}
        it { should allow_mass_assignment_of(:location)}
        it { should allow_mass_assignment_of(:location_attributes)}
        it { should allow_mass_assignment_of(:has_house)}
        it { should allow_mass_assignment_of(:rent_pref_min)}
        it { should allow_mass_assignment_of(:rent_pref_max)}
        it { should allow_mass_assignment_of(:admin)}
    end
  end

  describe "#age" do
    it "gives us the user's age" do
        p user
    end
  end

end
