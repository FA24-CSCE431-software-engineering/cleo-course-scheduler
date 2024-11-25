module CoursesHelper
  def format_prerequisites(course)
    grouped_prerequisites = course.prerequisites.includes(:prereq).group_by(&:equi_id)

    grouped_prerequisites.map do |equi_id, prereqs|
      prereq_titles = prereqs.map do |prereq|
        if prereq.prereq.present?
          "#{prereq.prereq.ccode} #{prereq.prereq.cnumber}"
        else
          nil
        end
      end.compact # Remove nil entries from the array

      prereq_titles.join(' or ')
    end.reject(&:empty?).join(' and ') # Remove empty strings from the array
  end
end
