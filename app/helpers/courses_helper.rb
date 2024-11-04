module CoursesHelper
    def format_prerequisites(course)
      grouped_prerequisites = course.prerequisites.includes(:prereq).group_by(&:equi_id)
      
      grouped_prerequisites.map do |equi_id, prereqs|
        prereq_titles = prereqs.map { |prereq| "#{prereq.prereq.ccode} #{prereq.prereq.cnumber}" }
        prereq_titles.join(' or ')
      end.join(' and ')
    end
  end
  