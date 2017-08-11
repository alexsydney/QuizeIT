
# XquizzIT is a app that creates user profiles
# Lets them build their own Quiz
# lets them complete Quizs
# records their scores for future logins
#
class UserProfile
require 'fileutils'

  def initialize(name, password)
    @name     = name
    @password = password

  end
  attr_accessor :name, :password
  def signIn(name,password)
      if ((@name== name) && (@password == password))
        true
      else
        false
      end
   end
  def signUp(name, password)
    #this create a user profile to a text file.
    puts "Enter new user name:"
    name = gets.chomp.strip
    puts "Enter your password:"
    password = gets.chomp.strip.to_i
    File.open("user_login.txt","a"){ |f|
      f << name }
  end

  def add_score(score)
    #this updates the quiz score to the user profile which is text file
  end
end
#####
class Quiz
  require "colorize"

  def initialize(topic, num_questions)
    @topic = topic
    @num = num_questions.to_i
    @q = []
    @a = []
  end
  attr_accessor :topic, :num, :q, :a

  def load_quiz # read all questions and answers in to arrays
    questions=[]
    answers=[]
    File.read("#{topic}_Qs.txt").each_line {|line| questions.push line.chomp}
    File.read("#{topic}_As.txt").each_line {|line| answers.push line.chomp}
    # response = {
    #   :q => questions,
    #   :a => answers
    # }
    return questions, answers
    end



  def build_quiz()
    for i in 0...@num
      puts "please enter you question".yellow
      question= gets.chomp
      puts "and the answer is?  ".yellow
      answer = gets.chomp.capitalize
      @q << question
      @a << answer
    end
    File.open("#{topic}_Qs.txt", "w+") do |f|
      @q.each { |element| f.puts(element) }
    end
    File.open("#{topic}_As.txt", "w+") do |f|
      @a.each { |element| f.puts(element) }
    end
  end

  def do_quiz(num_of_qs, q, a)
    totalPoints=0
    count=0
    qu = q
    an = a
    while count < num_of_qs
      #select a random question and answer pair
      listC = @q.count
      arrayNum = rand(listC)
      question = qu[arrayNum]
      ans      = an[arrayNum]


      puts "Question #{count + 1}".yellow
      puts "#{question}".yellow
      answer = gets.chomp.capitalize
      if answer == ans
        puts "Got it!"
        points = 1
      elsif answer.count(ans)/ans.length.to_f >0.6
        puts "oh thats so close, but spelling is important"
        puts "but I'll give you almost full points.\n it's spelt #{ans}"
        points = 0.5
      else
        puts "thats incorrect".red
        points =0
      end
      totalPoints += points
      count += 1
      #to avoid repeating the Q, delete the q and a pair on the while list
      qu.delete_at(arrayNum)
      an.delete_at(arrayNum)
    end
    return totalPoints
  end
end
#####
# system("clear")
# puts "Welcome to QuizeIT game"
# puts "Do you have a profile? [y,n]"
# yorn = gets.chomp.downcase
# if yorn == "n"
#   puts "please enter your name"
#   name = gets.chomp.capitalize
#   puts "please enter password in numbers"
#   pw = gets.chomp.to_i
#   user = UserProfile.new(name,pw)
# elsif yorn =="y"
#   puts "..."
# else
#   puts "error"
# end
# count = 0
# while count < 3
#   system("clear")
#   puts "Please enter user name"
#   currenName = gets.chomp.strip
#   puts "Login : #{currenName}"
#   puts "Enter password:"
#   currentPassword = gets.chomp.strip.to_i
#
#   if (user.signIn(currenName,currentPassword) == true)
#     t = Time.now
#     score = 300
#     File.open("user_info.txt","a"){}
#     puts "Hey #{user.name}, test score had: #{score} on #{t.strftime("%d/%m/%Y %H:%M:%S")}"
#
#     break
#   else
#     puts "You enter wrong user login and password"
#     count += 1
#     puts "count is #{count}"
#     if (count == 3)
#        puts "Your account had been locked after 3 times."
#     end
#   end
#
# end
#########


#BUILD THE QUIZ
puts "What is the topic of your quiz"
topic= gets.chomp
puts "How many questions  would you lke to add?"
n= gets.chomp

topic = Quiz.new(topic, n)

questions = topic.load_quiz[0]
answers   = topic.load_quiz[1]

# puts questions
# puts answers


puts topic.do_quiz(3, questions, answers)
# topic.build_quiz()
#
# #LOAD THE QUIZ
# puts "please choose your quiz topic \n #{topic}"
#
# #topic.load_quiz
# # puts topic.q
# # puts topic.a
# #topic.do_quiz(4)
#
# puts "#{topic.do_quiz(4)} out of #{4}"

#write score to user profile
