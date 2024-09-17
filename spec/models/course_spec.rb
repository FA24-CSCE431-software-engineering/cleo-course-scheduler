require 'rails_helper'

RSpec.describe Course, type: :model do
    context "When creating a valid course" do
        it "is valid with valid attributes" do
            course = Course.create(crn: 1, cname: "Software Engineering", credit_hours: 3)
            expect(course).to be_valid
        end
    end

    context "When creating an invalid course" do
        it "is invalid with missing attributes" do
            course = Course.create(crn: 1)
            expect(course).to be_invalid
        end
    end
end