require 'rails_helper'

RSpec.describe DegreeRequirement, type: :degree_requirements do
    before(:each) do
        @default_course = Course.create(crn: 1, cname: "Software Engineering", credit_hours: 3)
        @default_major = Major.create(mname: "Computer Science", cname: "College of Engineering")
    end

    context "When creating a valid degree requirement" do
        it "is valid with valid attributes" do
            req = DegreeRequirement.create(course_id: @default_course.crn, major_id: @default_major.id)
            expect(req).to be_valid
        end
    end

    context "When creating an invalid degree requirement" do
        it "is invalid with invalid attributes" do
            req = DegreeRequirement.new(course_id: nil, major_id: @default_major.id)
            expect(req).to be_invalid
        end
    end

    context "When creating a duplicate degree requirement" do
        it "is invalid with duplicate course_id, major_id" do
            r1 = DegreeRequirement.create(course_id: @default_course.crn, major_id: @default_major.id)
            r2 = DegreeRequirement.new(course_id: @default_course.crn, major_id: @default_major.id)
            expect(r2).to be_invalid
        end
    end

    context "When creating a two degree requirement" do
        it "is valid with unique course_id, major_id" do
            major = Major.create(mname: "Computing", cname: "College of Engineering")
            r1 = DegreeRequirement.create(course_id: @default_course.crn, major_id: @default_major.id)
            r2 = DegreeRequirement.create(course_id: @default_course.crn, major_id: major.id)
            expect(r2).to be_valid
        end
    end

end