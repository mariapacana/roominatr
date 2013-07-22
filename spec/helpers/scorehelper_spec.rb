require 'spec_helper'


describe ScoreHelper do

	# let(:sub) { create(:submission_with_responses) }
	let(:user) { create(:user_with_submissions) }

	describe '#update_category_score' do
		it "correctly sums the me answers" do
			# p sub
			p user
			p user.submissions
		end
	end
end