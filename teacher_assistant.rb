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
  # def initialize
  # end

  # def 
  # end

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

total_class = []

grade_reader = GradeReader.new

students = grade_reader.grades_for_students('students.csv')

grade_averager = GradeAverager.new

students.each do |student|
	student.average = grade_averager.calculate_average(student.grades)
	total_class << student.average
	puts "#{student.name}: #{student.average}"

	if student.average >= 90
		puts "#{student.name}: A"
	elsif student.average >= 80 && student.average < 90
		puts "#{student.name}: B"
	elsif student.average >= 70 && student.average < 80
		puts "#{student.name}: C"
	elsif student.average >= 60 && student.average < 70
		puts "#{student.name}: D"
	elsif student.average < 60
		puts "#{student.name}: F"
	end
end

puts "Maximum score of the class " + total_class.max.to_s
puts "Minimum score of the class " + total_class.min.to_s
puts "Standard deviation of the class was " + total_class.stdev.to_s




#it was looking for an array instead of a string, so I put them into arrays

CSV.open("final_grades.csv", "w") do |final_grades|
  final_grades << total_class
  final_grades << [total_class.max]
  final_grades << [total_class.min]
  final_grades << [total_class.stdev]
end



# Save into an array
# The average score across the class is outputted
# The minimum score across the class is outputted
# The maximum score across the class is outputted
# The standard deviation across the class is outputted

# The file should be sorted by last name, first name
# The file should contain the average score (rounded to the first decimal) and the letter grade for each student

# Acceptance Criteria: 
# * I receive an error if the file does not exist 
# * I receive an error if the file is not the intended extension 
# * I receive an error if an entry doesn't have the same number of grades as the others 
# * If the file is valid, it provides the source data that runs the program

