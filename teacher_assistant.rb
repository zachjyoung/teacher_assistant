# GradeReader - an object that is responsible for reading in grade data from a CSV.
# AssignmentGrade - an object that encapsulates the concept of a given assignment grade
# FinalGrade - an object that encapsulates the concept of a student's final grade
# Student - an object that represents a participant in a class
# GradeSummary - an object that encapsulates the concept of the class' aggregate performance

require 'CSV'

class GraderReader 
  def csv_reader
    CSV.foreach('students.csv') do |row|
    puts row.join(' | ')
    end
  end
end

class AssignmentGrade < GradeReader
end

class FinalGrade < GradeReader

end

class Student < GradeReader
end

class GradeSummary < GradeReader
end

csv_reader

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