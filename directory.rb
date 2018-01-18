
# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Micheal Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Kruger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]
require 'date'
# and define some methods
def input_students
  puts "Please enter the names of the students"
  puts "To finish the list, just hit enter twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter the student's cohort month or just hit enter"
    month = gets.chomp.downcase
    month = "january" if month.empty?
    begin
       Date.parse(month)
    rescue ArgumentError
       puts "Please enter a valid month or just hit enter"
       month = gets.chomp.downcase
    end
    month = month.downcase.to_sym
    students << {name: name, cohort: month}
    puts students.count < 2 ? "That's one student" : "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end  
  # return the array of students
  students
end  
def print_header
  puts "The students of the Academy of Evil".center(50)
  puts "--------------------------------".center(50)
end
def print(students)
  cohorts = []
  students.each do |student|
    cohorts.push(student[:cohort].to_s) if !cohorts.include?(student[:cohort].to_s)
    #puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end 
  cohorts.sort_by! {|month| Date.parse(month)}
  cohorts.each do |cohort|
    puts "#{cohort.capitalize} cohort".center(50)
    students.each do |student|
      puts student[:name].center(50) if student[:cohort] == cohort.to_sym
      #puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
    end 
  end  
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(50)
end  
# nothing happens until we call the methods
students = input_students
if !students.empty?
  print_header
  print(students)
  print_footer(students)
  puts
else
  puts "You didn't really think we were going to print an empty list did you?"
  puts
end  
