class Person

	attr_accessor :name
	
	def initialize(name)
		@name = name
	end

	def greeting
		puts "Hi, my name is #{name}"
	end
end

class Student < Person

	def learn  
    	puts "I get it!"  
  	end
end

class Instructor < Person

	def teach
		puts "Everything in Ruby is an Object"
	end
end

Chris = Instructor.new("Chris")
Chris.greeting

Cristina = Student.new("Cristina")
Cristina.greeting

Chris.teach
Cristina.learn

Cristina.teach
# When the previous line is executed one gets the following error message,
# people.rb:37:in `<main>': undefined method `teach' for #<Student:0x007f94b2855810 @name="Cristina"> (NoMethodError)
# The call does not work because the method learn is not part of class Instructor
