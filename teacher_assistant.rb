# GradeReader - an object that is responsible for reading in grade data from a CSV.
# AssignmentGrade - an object that encapsulates the concept of a given assignment grade
# FinalGrade - an object that encapsulates the concept of a student's final grade
# Student - an object that represents a participant in a class
# GradeSummary - an object that encapsulates the concept of the class' aggregate performance

require 'CSV'
require 'pry'

class GradeReader 

  def initialize
    CSV.foreach('students.csv') do |row|
    puts row.join(',')
    end
  end

  def grades_for_students(file_path)
  	students = []

  	CSV.foreach(file_path) do |row|
  		student = grades_for_student(row)
  		students << student
  	end

  	students
  end

  def grades_for_student(row)
  	name = row.shift
  	grades = row.collect{|i| i.to_i}
  	student = Student.new(name, grades)

  	# student = {}
  	# name = row.shift
  	# student[:name] = name
  	# student[:grade] = row

  	student
	end	
end


class GradeAverager < GradeReader
	def initialize

	end

	def calculate_average(grades)
		grades.inject{|sum, grade| sum + grade } / grades.count
	end
end

class FinalGrade < GradeReader

end

class Student < GradeReader
	attr_accessor :name, :grades, :average
	
	def initialize(name, grades)
		@name = name
		@grades = grades
	end
end

class GradeSummary < GradeReader
end

grade_reader = GradeReader.new

students = grade_reader.grades_for_students('students.csv')

grade_averager = GradeAverager.new

students.each do |student|
	student.average = grade_averager.calculate_average(student.grades)
	puts "#{student.name}: #{student.average}"
end




# Design a CSV with the data that is provided in implementation details
# Load that CSV into an appropriate data structure that correlates student names with all of their grades.
# Once loaded, list the students and their grades

# With the loaded data, calculate a student's average based on their test scores
# Output each student's name and average score

# Take the average score for each student and assign a correlating letter grade
# If the score is greater than or equal to 90, assign an A
# If the score is greater than or equal to 80 but less than 90, assign a B
# If the score is greater than or equal to 70 but less than 80, assign a C
# If the score is greater than or equal to 60 but less than 70, assign a D
# If the score is less than 60, assign an F
# Output each student's name and final letter grade

# The file should be sorted by last name, first name
# The file should contain the average score (rounded to the first decimal) and the letter grade for each student

# The average score across the class is outputted
# The minimum score across the class is outputted
# The maximum score across the class is outputted
# The standard deviation across the class is outputted

# Acceptance Criteria: 
# * I receive an error if the file does not exist 
# * I receive an error if the file is not the intended extension 
# * I receive an error if an entry doesn't have the same number of grades as the others 
# * If the file is valid, it provides the source data that runs the program