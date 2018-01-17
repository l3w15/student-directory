# lets put all the students into an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Micheal Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Kruger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
puts "The students of the Academy of Evil"
puts "--------------------------------"
# and then print them
students.each do |student|
  puts student
end  
# finally, we print the total number of students
puts "Overall, we have #{students.count} great students"