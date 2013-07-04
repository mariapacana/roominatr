require 'spec_helper'

describe Category do

  describe "#initialize" do
    it { should have_many(:surveys) }
    it { should validate_presence_of(:name) }
  end  

end
