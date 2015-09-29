require 'rails_helper'

RSpec.describe String, type: :model do
 
	describe "String#possessive" do
	  it "should turn Steelers into Steelers'" do
	    "Steelers".possessive.should == "Steelers'"
	  end
	  it "should turn sam into sam's" do
	    "sam".possessive.should == "sam's"
	  end
	end

end
