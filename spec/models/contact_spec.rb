require 'spec_helper'

describe Contact do
	it "is valid with a name" do
		contact = Contact.new(
				:name => 'Jeff Goldblum'
			)
		expect(contact).to be_valid
	end

	it "is valid without a name" do
		contact = Contact.new(
				:department => 'Department of Better Technology'
			)
		expect(contact).to have(0).errors_on(:name)
	end
end