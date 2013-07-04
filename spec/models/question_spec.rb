require 'spec_helper'

describe Question do

  describe "#initialize" do

    it { should belong_to(:survey) }
    it { should have_many(:answers) }
    it { should validate_presence_of(:body) }

    #If type roommate, body = "how woudl you like rmm to answer"

  end  


end
