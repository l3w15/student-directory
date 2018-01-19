
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
require'csv'
@students = []
# and define some methods
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end 

def process(selection)
  case selection
  when "1"; input_students
  when "2"; show_students
  when "3"; save_students
  when "4"; get_load_file
  when "9"; exit
  else puts "Sorry didn't get that, please try again"
  end
end

def print_menu
  puts "1. Add new student(s)"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load a list from another file"
  puts "9. Exit"
end  

def show_students
  if !@students.empty?
    print_header
    print_students_list
    print_footer
    puts
  else
    puts "You didn't really think we were going to print an empty list did you?"
    puts
  end 
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish the list, just hit enter twice"
  # get the first name
  @name = STDIN.gets.chomp
  #while the name is not empty, repeat this code
  get_month
  while !@name.empty? do
    puts @students.count < 2 ? "That's one student" : "Now we have #{@students.count} students"
    # get another name from the user
    @name = STDIN.gets.chomp
  end 
end

def get_month
  puts "Please enter the student's cohort month or just hit enter"
  @month = STDIN.gets.chomp.downcase
  check_month
  @month = @month.downcase.to_sym
  @students << {name: @name, cohort: @month}
end

def check_month
  @month = "january" if @month.empty?
  begin
    Date.parse(@month)
  rescue ArgumentError
     puts "Please enter a valid month or just hit enter"
     @month = STDIN.gets.chomp.downcase
     check_month
  end
end  

def print_header
  puts "The students of the Academy of Evil".center(50)
  puts "--------------------------".center(50)
end

def print_students_list
  cohorts = []
  @students.each do |student|
    cohorts.push(student[:cohort].to_s) if !cohorts.include?(student[:cohort].to_s)
    #puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end 
  cohorts.sort_by! {|month| Date.parse(month)}
  cohorts.each do |cohort|
    puts "#{cohort} cohort".center(50).upcase
    @students.each do |student|
      puts student[:name].center(50) if student[:cohort] == cohort.to_sym
      #puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
    end 
  end
  puts "--------------------------".center(50)
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end  

def save_students
  puts "Enter a (.csv) filename to save to" 
  filename = STDIN.gets.chomp
  filename = filename + ".csv" if filename[-4..-1] != ".csv"
  CSV.open(filename, "wb") do |file|
    @students.each do |student|
      file << [student[:name], student[:cohort]]
    end
  end
  puts "Saved #{@students.count} students to #{filename}"
end  

def get_load_file
  puts "Enter a file name to load from" 
  filename = STDIN.gets.chomp
  if File.exists?(filename)
    load_students(filename)
  else 
    puts "Sorry, #{filename} not found"
  end  
end  

def load_students(filename)
  @students = []
  CSV.foreach(filename) do |row|
    name, cohort = row[0], row[1]
    @students << {name: name, cohort: cohort.to_sym}
  end
  puts "Loaded #{@students.count} students from #{filename}"
end  

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil? 
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end  
# nothing happens until we call the methods
try_load_students
interactive_menu


 
