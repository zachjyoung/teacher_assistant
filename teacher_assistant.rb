# GradeReader - an object that is responsible for reading in grade data from a CSV.
# AssignmentGrade - an object that encapsulates the concept of a given assignment grade
# FinalGrade - an object that encapsulates the concept of a student's final grade
# Student - an object that represents a participant in a class
# GradeSummary - an object that encapsulates the concept of the class' aggregate performance

require 'CSV'
require 'pry'
require 'ruby-standard-deviation'

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
  	grades = row.collect{ |i| i.to_i }
  	student = Student.new(name, grades)

  	student
	end	
end


class GradeAverager < GradeReader
	def initialize(grades)
		@grades = grades
	end

	def calculate_average
		@grades.inject{ |sum, grade| sum + grade } / @grades.count
	end
end

class FinalGrade < GradeReader
	def initialize(average)
		@average = average
	end

	def letter_grade
		if @average >= 90
			"A"
		elsif @average >= 80
			"B"
		elsif @average >= 70
			"C"
		elsif @average >= 60
			"D"
		else
			"F"
		end
	end
end

class Student < GradeReader
	def initialize(name, grades)
		@name = name
		@grades = grades
	end

	def stats
		averager = GradeAverager.new(@grades)
		grader = FinalGrade.new(averager.calculate_average)
	 	[@name, grader.letter_grade, averager.calculate_average]
	end
end

class GradeSummary < GradeReader
	def initialize
		@students = grades_for_students('students.csv')
	end

	def write_summary(file_name)
		CSV.open(file_name, "w") do |csv|
			@students.each do |student|
				csv << student.stats
			end
		end
	end
end


# puts "File bro?"
# input = gets.chomp

# summarizer = GradeSummary.new
# summarizer.write_summary(input)

total_class = []

grade_reader = GradeReader.new

students = grade_reader.grades_for_students('students.csv')

grade_averager = GradeAverager.new

students.each do |student|
	student.average = grade_averager.calculate_average(student.grades)
	total_class << student.average
end

puts "Maximum score of the class: #{total_class.max}." 
puts "Minimum score of the class: #{total_class.min}."
puts "Standard deviation of the class: #{total_class.stdev}."

