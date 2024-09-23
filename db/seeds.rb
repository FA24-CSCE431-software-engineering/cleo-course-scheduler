# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Course [No dependencies]

# rubocop:disable Layout/LineLength
# This is here since it would be annoying to refactor and hard to read if we did
@c110 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 110, cname: 'Programming I',
                                 description: 'Basic concepts in using computation to enhance problem solving abilities; understanding how people communicate with computers, and how computing affects society; computational thinking; representation of data; analysis of program behavior; methods for identifying and fixing errors in programs; understanding abilities and limitation of programs; development and execution of programs.', credit_hours: 4, lab_hours: 2)
@c111 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 111,
                                 cname: 'Introduction to Computer Science Concepts and Programming', description: 'Computation to enhance problem solving abilities; understanding how people communicate with computers, and how computing affects society; computational thinking; software design principles, including algorithm design, data representation, abstraction, modularity, structured and object oriented programming, documentation, testing, portability, and maintenance; understanding programs’ abilities and limitations; development and execution programs.', credit_hours: 4, lecture_hours: 3, lab_hours: 2)
@c120 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 120, cname: 'Program Design and Concepts',
                                 description: 'Extension of prior programming knowledge and creation of computer programs that solve problems; use of the C++ language; application of computational thinking to enhance problem solving; analysis of, design of and implementation of computer programs; use of basic and aggregate data types to develop functional and object oriented solutions; development of classes that use dynamic memory and avoid memory leaks; study of error handling strategies to develop more secure and robust programs.', credit_hours: 3, lecture_hours: 3, lab_hours: 1)
@c121 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 121, cname: 'Introduction to Program Design and Concepts',
                                 description: 'Computation to enhance problem solving abilities; computational thinking; understanding how people communicate with computers, how computing affects society; design and implementation of algorithms; data types, program control, iteration, functions, classes, and exceptions; understanding abstraction, modularity, code reuse, debugging, maintenance, and other aspects of software development; development and execution of programs.', credit_hours: 4, lecture_hours: 3, lab_hours: 2)
@c181 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 181, cname: 'Introduction to Computing',
                                 description: 'Introduction to the broad field of computing; presentations from industry and academia about how computer science concepts are used in research and end products; includes a major writing component.', credit_hours: 1, lecture_hours: 1)
@c221 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 221, cname: 'Data Structures and Algorithms',
                                 description: 'Specification and implementation of basic abstract data types and their associated algorithms including stacks, queues, lists, sorting and selection, searching, graphs, and hashing; performance tradeoffs of different implementations and asymptotic analysis of running time and memory usage; includes the execution of student programs written in C++.', credit_hours: 4, lecture_hours: 3, lab_hours: 2)
@c222 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 222, cname: 'Discrete Structures for Computing',
                                 description: 'Mathematical foundations from discrete mathematics for analyzing computer algorithms, for both correctness and performance; introduction to models of computation, including finite state machines and Turing machines.', credit_hours: 3, lecture_hours: 3)
@c312 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 312, cname: 'Computer Organization',
                                 description: "Computer systems from programmer's perspective including simple logic design, data representation and processor architecture, programming of processors, memory, control flow, input/output, and performance measurements; hands-on lab assignments.", credit_hours: 4, lecture_hours: 3, lab_hours: 2)
@c314 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 314, cname: 'Programming Languages',
                                 description: 'Exploration of the design space of programming languages via an in-depth study of two programming languages, one functional and one object-oriented; focuses on idiomatic uses of each language and on features characteristic for each language.', credit_hours: 3, lecture_hours: 3)
@c313 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 313, cname: 'Introduction to Computer Systems',
                                 description: 'Introduction to system support for application programs, both on single node and over network including OS application interface, inter-process communication, introduction to system and network programming, and simple computer security concepts; hands-on lab assignments.', credit_hours: 4, lecture_hours: 3, lab_hours: 2)
@c410 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 410, cname: 'Operating Systems',
                                 description: 'Hardware/software evolution leading to contemporary operating systems; basic operating systems concepts; methods of operating systems design and construction including algorithms for CPU scheduling, memory and general resource allocation, process coordination and management; case studies of several operating systems', credit_hours: 3, lecture_hours: 3)
@c431 = Course.find_or_create_by(ccode: 'CSCE', cnumber: 431, cname: 'Software Engineering',
                                 description: 'Application of engineering approach to computer software design and development; life cycle models, software requirements and specification; conceptual model design; detailed design; validation and verification; design quality assurance; software design/development environments and project management.', credit_hours: 3, lecture_hours: 2, lab_hours: 2)

@b209 = Course.find_or_create_by(ccode: 'ACCT', cnumber: 209, cname: 'Survey of Accounting Principles',
                                 description: 'Accounting survey for non-business majors; non-technical accounting procedures, preparation and interpretation of financial statements and internal control. May not be used to satisfy degree requirements for majors in business. Business majors who choose to take this course must do so on a satisfactory/unsatisfactory basis.', credit_hours: 3, lecture_hours: 3)

@m251 = Course.find_or_create_by(ccode: 'MATH', cnumber: 251, cname: 'Engineering Mathematics III',
                                 description: "Engineering Mathematics III. Vector algebra, calculus of functions of several variables, partial derivatives, directional derivatives, gradient, multiple integration, line and surface integrals, Green's and Stokes' theorems.", credit_hours: 3, lecture_hours: 3)

@e104 = Course.find_or_create_by(ccode: 'ENGL', cnumber: 104, cname: 'Composition and Rhetoric',
                                 description: 'Composition and Rhetoric. Focus on referential and persuasive researched essays through the development of analytical reading ability, critical thinking and library research skills.', credit_hours: 3, lecture_hours: 3)

@a149 = Course.find_or_create_by(ccode: 'ARTS', cnumber: 149, cname: 'Art History Survey I',
                                 description: 'Survey of architecture, painting, sculpture and the minor arts from prehistoric times to 14th century.', credit_hours: 3, lecture_hours: 3)

# Major [No dependencies]
@cs = Major.find_or_create_by(mname: 'Computer Science', cname: 'College of Engineering')
@ce = Major.find_or_create_by(mname: 'Chemical Engineering', cname: 'College of Engineering')
@be = Major.find_or_create_by(mname: 'Biomedical Engineering', cname: 'College of Engineering')

# Student [Dependency on major]
@s1 = Student.find_or_create_by(uin: 123_456_789, first_name: 'Alpha', last_name: 'Brook', email: 'JA@tamu.edu',
                                enrol_year: 2000, enrol_semester: 0, grad_year: 2004, grad_semester: 1, major_id: @cs.id)
@s2 = Student.find_or_create_by(uin: 987_654_321, first_name: 'Beta', last_name: 'Charlie', email: 'JA@tamu.edu',
                                enrol_year: 2000, enrol_semester: 0, grad_year: 2004, grad_semester: 1, major_id: @cs.id)

# Student Course [Dependencies on Student and Course]
StudentCourse.find_or_create_by(student_id: @s1.id, course_id: @c110.id)
StudentCourse.find_or_create_by(student_id: @s1.id, course_id: @c120.id)
StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @c221.id)
StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @c181.id)
StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @e104.id)

StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @c121.id)
StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @c181.id)
StudentCourse.find_or_create_by(student_id: @s2.id, course_id: @b209.id)

# Track [Dependency on Course]
Track.find_or_create_by(course_id: @c410.id, tname: 'Systems')
Track.find_or_create_by(course_id: @c431.id, tname: 'Software')

# Emphasis [Dependency on Course]
Emphasis.find_or_create_by(course_id: @m251.id, ename: 'Math')
Emphasis.find_or_create_by(course_id: @b209.id, ename: 'Business')

# Prereq [Dependency on Course]
Prerequisite.find_or_create_by(course_id: @c120.id, prereq_id: @c110.id)
Prerequisite.find_or_create_by(course_id: @c120.id, prereq_id: @c111.id)

# Core Categories [Dependency on Course]
CoreCategories.find_or_create_by(course_id: @e104.id, cname: 'Communication')
CoreCategories.find_or_create_by(course_id: @a149.id, cname: 'Creative Arts')

# Degree Requirement [Dependencides on Major and Course]
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c181.id)
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c221.id)
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c222.id)
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c312.id)
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c314.id)
DegreeRequirement.find_or_create_by(major_id: @cs.id, course_id: @c313.id)
