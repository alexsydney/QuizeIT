# make a game to learn the classes names using the commonality game!
#asks 3 questions and assigns a score

# names= ["Richard", "Tessa", "Olivia", "Nathan", "Sakshi", "David",
#         "Kevin", "Tom", "Cindy", "John", "Terry", "Sana", "Travis",
#         "Takuya", "Saff", "Shaun", "Khaled", "Alex", "Biannca", "Omar",
#         "Sophie", "Tim"
# ]
# commonality= ["Coding", "UX", "Sushi & cats", "Wants to go to USA",
#   "1st season of Suits", "Dragonball Z", "Rick & Morty", "Been to USA", "summer Ale",
#   "Listens to Vinyl", "working in Digital", "Likes Watches", "Use(d) Tinder",
#   "Marketing", "Start Ups", "Digital Marketing too","Tae Kwon Do - red belt", "went to ANU",
#   "reads Robin Robb", "owns a bike", "tequila", "Python"
# ]
#
# def remember_game(names, commonalities)
#   #House Keeping
#   n= names
#   c=commonalities
#   nL= n.count
#   cL = c.count
#   puts "your lists are not equal in length" if nL != cL
#   #introduce the game to the user
#   puts "This is the COMMONALITY QUIZ"
#   puts
#   puts "Lets quiz you on your classmates names!"
#   puts "You will get the commonality, then you have 3 guesses of whom it is"
#   puts "You will get a clue each incorrect answer, BUT"
#   puts "the game is scored so best to get it first go"
#   puts
#   start = "n"
#   while start != "y"
#     puts "ready?.. [type 'y' to start]"
#     start=gets.chomp
#   end
#   totalPoints=0
#   count=0
#   while count <5
#     n= names
#     c=commonalities
#     nL= n.count
#     cL = c.count
#     arrayNum= rand(nL)
#     answerN= n[arrayNum]
#     answerC= c[arrayNum]
#     puts "Question #{count+1}"
#     puts "Your commonality is #{answerC}"
#     answer=gets.chomp.capitalize
#     #attempt One
#     if answer == answerN
#       puts "Got it!"
#       points = 3
#     elsif answer.count(answerN)/answerN.length >0.6
#       puts "oh thats so close, but spelling is important"
#       puts "but I'll give you almost full points.\n it's spelt #{answerN}"
#       points = 2.5
#     else
#       puts "Nope try again, this person start with a  #{answerN[0]}"
#       answer=gets.chomp.capitalize
#       #attempt Two
#       if answer == answerN
#         puts "Got it!"
#         points = 2
#       elsif answer.count(answerN)/answerN.length >0.6
#         puts "oh not exactly, spelling is important"
#         puts "but I'll give you almost some points. \n it's spelt #{answerN}"
#         points = 1.5
#       else
#         print "Still not them... their name looks like this #{answerN[0]}"
#         for i in 0...answerN[0...-1].length
#           print "*"
#         end
#         puts
#         answer=gets.chomp.capitalize
#         #attempt Three
#         if answer == answerN
#           puts "Got it!"
#           points = 1
#         elsif answer.count(answerN)/answerN.length >0.6
#           puts "Gee its close, but spelling is important"
#           puts "but I'll give you some points.\n it's spelt #{answerN}"
#           points = 0.5
#         else
#           puts "Nope not them. It was #{answerN}"
#           points = 0
#         end
#       end
#     end
#
#     #prepare for the next question
#     totalPoints += points
#     count += 1
#     n.delete_at(arrayNum)
#     c.delete_at(arrayNum)
#   end
#   puts "thats it"
#   puts "You scored #{totalPoints} out of 15"
# end
#
# remember_game(names, commonality)

# create a class QuizeGame
     # create a empty quize hash to store key and value of each quize
     # create an initialize method to initialize key and value to pass on argumenent
     # create an addQuize method to add a new pair key and value of new quize
     # create a updateQuize method to update/change anything need for quize
     # create a scoreQuize method to calculate the score of matching quize game

    #

    # file into arrayNum
    # names = []
    # loginName = []
    # name = ''
    # puts "Enter name "
    # name = gets.chomp.to_s
    # file.open[]
######### Alex path ########################
    # create class UserProfile to store information from users to login
    class UserProfile
    require 'fileutils'

      def initialize(name, password)
        @name = name
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
      # def signUp(name, password)
      #   puts "Enter new user name:"
      #   name = gets.chomp.strip
      #   puts "Enter your password:"
      #   password = gets.chomp.strip.to_i
      #   File.open("user_login.txt","a") do
      #
      #   end

        def write_to_file(name,password)
          File.open(user_login.txt,'a') do |file|
            puts "Enter user name"
            name = gets.chomp.strip
            file << name
            puts "What password like to use for login"
            password = gets.chomp.strip.to_i
            file << password
          end
        end


      # def password_correct(password)
      #   if(@password)
      #   else
      #   end
      # end
    end
############# End of UserProfile Class ##########

########### Begin of Ric Path




########### End of Ric path of code  ##############
########## Alex for enter question and answer into hash
# class QuizeGame
#     # def initialize
#     def initialize(question, answer, questList, answerList)
#       @question = quesion
#       @answer = answer
#       @questList = []
#       @answerList = []
#
#     end
#
#     attr_accessor :question, :answer, :questList, :answerList
#     def storedQ_A(q, a)
#       @question = q
#       @answer = a
#       # puts "How many question and ans"
#     end
#
# end
########## end alex question and answer hash  #########

######### Begin Alex Path for testing of alex code #########
system("clear")
user = UserProfile.new("Alex",88888)
puts "Welcome to QuizeIT game"
count = 0
while count < 3
  puts "Please enter user login"
  currenName = gets.chomp.strip
  puts "Login : #{currenName}"
  puts "Enter password:"
  currentPassword = gets.chomp.strip.to_i

  if (user.signIn(currenName,currentPassword) == true)
    t = Time.now
    # puts t.strftime("%d/%m/%Y %H:%M:%S")
    # call QuizeGame class to play game here
    # pretent final score will be 300
    # puts "Infor - Login: #{currentLogin} and name #{user.name}"
    score = 300
    File.open("user_infor.txt","a"){}
    puts "Hey #{user.name}, test score had: #{score} on #{t.strftime("%d/%m/%Y %H:%M:%S")}"

    break
  else
    puts "You enter wrong user login and password"
    count += 1
    puts "count is #{count}"
    if (count == 3)
       puts "Your account had been locked after 3 times."
    end
  end

end



# if(count == 3)
#   puts "Your account had been locked out after 3 times. Please contact us to for unlock your account."
# end


############# End of Alex Path testing ###############
