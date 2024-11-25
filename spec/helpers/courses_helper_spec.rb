require 'rails_helper'

RSpec.describe CoursesHelper, type: :helper do
  describe '#format_prerequisites' do
    let(:prerequisites) { instance_double('ActiveRecord::Associations::CollectionProxy') }
    let(:course) { double('Course', prerequisites: prerequisites) }

    context 'when the course has prerequisites grouped by equi_id' do
      it 'returns the prerequisites formatted as "course1 or course2 and course3"' do
        prereq1 = double('Prerequisite', equi_id: 1, prereq: double('Course', ccode: 'CSCE', cnumber: '101'))
        prereq2 = double('Prerequisite', equi_id: 1, prereq: double('Course', ccode: 'CSCE', cnumber: '102'))
        prereq3 = double('Prerequisite', equi_id: 2, prereq: double('Course', ccode: 'CSCE', cnumber: '201'))

        allow(prerequisites).to receive(:includes).with(:prereq).and_return([prereq1, prereq2, prereq3])
        allow(prerequisites).to receive(:group_by).and_return({
          1 => [prereq1, prereq2],
          2 => [prereq3]
        })

        result = helper.format_prerequisites(course)

        expect(result).to eq('CSCE 101 or CSCE 102 and CSCE 201')
      end
    end

    context 'when the course has no prerequisites' do
      it 'returns an empty string' do
        allow(prerequisites).to receive(:includes).with(:prereq).and_return([])
        allow(prerequisites).to receive(:group_by).and_return({})

        result = helper.format_prerequisites(course)

        expect(result).to eq('')
      end
    end

    context 'when prerequisites have missing data' do
      it 'handles missing prerequisite data gracefully' do
        prereq1 = double('Prerequisite', equi_id: 1, prereq: nil)

        allow(prerequisites).to receive(:includes).with(:prereq).and_return([prereq1])
        allow(prerequisites).to receive(:group_by).and_return({
          1 => [prereq1]
        })

        result = helper.format_prerequisites(course)

        expect(result).to eq('')
      end
    end
  end
end
