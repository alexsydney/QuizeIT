

# XquizzIT is a app that creates user profiles
# Lets them build their own Quiz
# lets them complete Quizs
# records their scores for future logins
#
def load_profile(name, password)
  lines = []
  File.read("Users/UserProfiles.txt").each_line {|line|
    lines << line.chomp
  }
  for i in 0...lines.length
    if lines[i] == name
      if lines[i+1] == password
        return lines[i], lines[i+1], lines[i+2]
        break
      end
    end
  end
  false
end

def save_profile(name, password)
  lines = []
  File.read("Users/UserProfiles.txt").each_line {|line|
    lines << line.chomp
  }
  for i in 0...lines.length
    if lines[i] == name
      if lines[i+1] == password
        lines[i+2] = $currentUser.total_points
        break
      end
    end
  end
  File.open("Users/UserProfiles.txt", "w+") do |f|
    lines.each { |element| f.puts(element) }
  end
end


require "colorize"
require "date"
puts Time.now.strftime("%d/%m/%Y %H:%M:%S %Z")

class UserProfile
require 'fileutils'

  def initialize(name, password, score=0)
    @name     = name
    @password = password
    @score    = score

  end
  attr_accessor :name, :password

  def signIn(name,password)
      if ((@name== name) && (@password == password))
        true
      else
        false
      end
   end


  # def signUp(name, password)
  #   #this create a user profile to a text file.
  #   puts "Enter new user name:"
  #   name = gets.chomp.strip
  #   puts "Enter your password:"
  #   password = gets.chomp.strip.to_i
  #   File.open("user_login.txt","a"){ |f|
  #     f << name }
  # end

end
###############
def load_quiz (topic)
  topic = topic # read all questions and answers in to arrays
  questions=[]
  answers=[]
  File.read("quiz/#{topic}/#{topic}_Qs.txt").each_line {|line| questions.push line.chomp}
  File.read("quiz/#{topic}/#{topic}_As.txt").each_line {|line| answers.push line.chomp}
  # response = {
  #   :q => questions,
  #   :a => answers
  # }
  return questions, answers, questions.count, topic
end
#####
class Quiz
  require "colorize"

  def initialize(topic, num_questions, q=[], a=[])
    @topic = topic
    @num = num_questions.to_i
    @q = q
    @a = a
  end
  attr_accessor :topic, :num, :q, :a

  def build_quiz()
    for i in 0...@num
      puts "please enter you question".yellow
      question= gets.chomp
      puts "and the answer is?  ".yellow
      answer = gets.chomp.capitalize
      @q << question
      @a << answer
    end
    system("mkdir quiz/#{topic}")
    File.open("quiz/#{topic}/#{topic}_Qs.txt", "w+") do |f|
      @q.each { |element| f.puts(element) }
    end
    File.open("quiz/#{topic}/#{topic}_As.txt", "w+") do |f|
      @a.each { |element| f.puts(element) }
    end
    puts "Well done, the quiz #{@topic} is ready"
  end

  def do_quiz(num_of_qs)
    totalPoints=0
    count=0
    qu = @q
    an = @a
    while count < num_of_qs
      #select a random question and answer pair
      listC = @q.count
      arrayNum = rand(listC)
      question = qu[arrayNum]
      ans      = an[arrayNum]


      puts "Question #{count + 1}".yellow
      puts "#{question}".green
      answer = gets.chomp.capitalize
      if answer == ans
        puts "Got it!".blue
        points = 1
      elsif answer.count(ans)/ans.length.to_f >0.6
        puts "oh thats so close, but spelling is important".blue
        puts "but I'll give you almost full points.\n it's spelt #{ans}".blue
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

#BUILD THE QUIZ
def make_quiz
  puts "What is the topic of your quiz"
  topic= gets.chomp.gsub(" ", "_")
  puts "How many questions  would you lke to add?"
  n= gets.chomp
  #this create a new class for a quiz topic
  topic = Quiz.new(topic, n)
  #now we input the questions
  topic.build_quiz()
end
#LOAD THE QUIZ
def load_screen

  ls = Dir.glob("**/")
  ls.shift
  for i in 0...ls.count
    ls[i] = ls[i].gsub("/", "").gsub("quiz", "")
  end
  ls.pop
  quizs = []
  ls.each{|topic|
    item = load_quiz(topic)
    quizs << Quiz.new(item[3], item[2], item[0], item[1])
  }
  return quizs

end

class Points
  #initialize the class from user profile
  def initialize(points, total_questions)
    @total_points  = points
    @total_quest   = total_questions
  end
  attr_accessor :total_points, :total_quest
  #use to add more points to users total points
  def addPoints(score)
    @total_points += score
  end
  def addQuest(num)
    @total_quest += num
  end
  # create a percentage
  def percent(score, questions)
    questions/score*100
  end
  #total percentage
  def totalPercent()
    @total_points/@total_quest.to_f*100
  end
  def save_score
  end
end

def login
  puts "Welcome to XquizzIT \n"
  puts "Do you have a profile? [y/n]"
  yn = gets.chomp.downcase
  case yn
  when "y"
    puts "please enter your name".green
    name = gets.chomp.capitalize
    puts "please enter password in numbers".green
    pw = gets.chomp.to_s
    if load_profile(name, pw) == false
      puts "No profile found"
      login
    end
    previousUser = load_profile(name, pw)
    $user = UserProfile.new(name,pw)
    $currentUser = Points.new(previousUser[2].to_i,0)
  when "n"
    puts "please enter your name".green
    name = gets.chomp.capitalize
    puts "please enter password in numbers".green
    pw = gets.chomp.to_s
    $user = UserProfile.new(name,pw)
    File.open("Users/UserProfiles.txt","a"){ |f|
      f << "\n#{name}"
      f << "\n#{pw}"
      f << "\n0"}
    $currentUser = Points.new(0,0)
  else
    login
  end
  puts "your total points are #{$currentUser.total_points}"
end


def menu
  puts "________________________"
  puts "MENU".yellow
  puts ""
  puts "[1] Complete a quiz \n[2] Make Quiz \n[3] Quit".green
  choice = gets.chomp.to_i
  case choice
  when 1
    $chosenQuiz = load_screen

    puts "Choose a quiz from below".yellow
    puts ""
    count = 1
    $chosenQuiz.each{|name|
      puts "[#{count}] #{name.topic}".green
      count +=1}
    choice = (gets.chomp.to_i )- 1
    if choice <0 || choice > $chosenQuiz.count
      puts "please make a valid choice"
      load_screen
    end
    puts "how many questions would you like max is #{$chosenQuiz[choice].num}".yellow
    num_of_q = gets.chomp.to_i
    points = $chosenQuiz[choice].do_quiz(num_of_q)
    $currentUser.addPoints(points)
    $currentUser.addQuest(num_of_q)
    puts "you scored points are #{points} out of #{num_of_q}".yellow
    puts "Thats #{$currentUser.percent(points, num_of_q)}%".yellow
    menu
  when 2
    make_quiz
    menu
  when 3
    puts "your total points are #{$currentUser.total_points}"
    sleep(2)
    puts "bye "
    #find users score line in userProfiles.txt
    #update text file to refelct final score
    print $user.name
    puts ""
    save_profile($user.name, $user.password)
    #ARE USER SCORES SAVED???
    abort
  else
    puts "Not a valid choice please try again"
    system("clear")
    menu
  end
end

login
for i in 0..3
  print "*"
  sleep(1)
end
system("clear")
menu
