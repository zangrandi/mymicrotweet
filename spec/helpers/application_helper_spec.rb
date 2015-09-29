require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  
	context "#parse_text" do
		it "should parse mention to usernames" do
			post = create(:post, text: "I think @bradpitt is awesome")
			expect(helper.parse_text(post.text)).to eql(
				"I think <a href=\"/bradpitt\">@bradpitt</a> is awesome"
			)
		end

		it "should split punctuation from mentions" do
			post = create(:post, text: "I think Brad Pitt is awesome, right @bradpitt?")
			expect(helper.parse_text(post.text)).to eql(
				"I think Brad Pitt is awesome, right <a href=\"/bradpitt\">@bradpitt</a>?"
			)
		end

		it "should parse links in text to proper html" do
			post = create(:post, text: "Hey people look at this: www.facebook.com")
			expect(helper.parse_text(post.text)).to eql(
				"Hey people look at this: <a href=\"http://www.facebook.com\">www.facebook.com</a>"
			)
		end
	end

end
