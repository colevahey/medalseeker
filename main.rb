#Cole Vahey Text Adventure

$shopitems = ["Axe: 50", "Rope: 10"]
$hasbeentoblue = false

class Player

  def initialize(name, money, tools, numkeys)
    @name = name 
    @money = money 
    @tools = tools
    @numkeys = numkeys 
  end

  def backpack
    puts "\033[H\033[2JWelcome to your backpack, #{@name}"
    puts "You currently have #{@money} coins"
    if @tools.length > 0
      print "In your tool belt you have "
      if @tools.length > 1 
        iter = 0 
        while iter < @tools.length - 1
          tool = @tools[iter]
          if tool.start_with?("A") || tool.start_with?("E") || tool.start_with?("I") || tool.start_with?("O") || tool.start_with?("U")
            print "an #{tool.downcase}" 
          else
            print "a #{tool.downcase}"
          end
          iter += 1
        end
        tool = @tools[@tools.length-1]
        if tool.start_with?("A") || tool.start_with?("E") || tool.start_with?("I") || tool.start_with?("O") || tool.start_with?("U")
          print " and an #{tool.downcase}" 
        else
          print " and a #{tool.downcase}"
        end
      elsif @tools.length == 1
        tool = @tools[0]
        if tool.start_with?("A") || tool.start_with?("E") || tool.start_with?("I") || tool.start_with?("O") || tool.start_with?("U")
          print "an #{tool.downcase}" 
        else
          print "a #{tool.downcase}"
        end
      end
      puts
    else
      puts "You have no tools in your tool belt"
    end
    if @numkeys > 0
      puts "You have #{@numkeys} keys"
    else
      puts "You have no keys"
    end
    puts "Press enter to continue"
    gets
    print "\033[H\033[2J"
  end

  def addmoney(addamount)
    @money += addamount
    return @money
  end
  
  def name
    return @name
  end

  def buyitem(item, price)
    if @money < price
      puts "You don't have enough money to buy that item"
    else
      @money -= price
      $shopitems = $shopitems - [item]
      4.times do item.chop! end
      @tools += [item]
      puts "You bought the #{item}"
    end
  end

  def showtools
    return @tools
  end

end

def start
  print "\033[H\033[2J\033[37m#{$titlescreen}"
  puts "Created by Cole Vahey"
  print "\n\n\n\nWhat is your name?\n>> "
  playername = gets.chomp
  print "\033[H\033[2J"
  $player = Player.new(playername, 55, [], 0)
  puts "Welcome to the game #{playername}"
  puts "You start in a small village"
  puts "The point of the game is to find the medallion"
  puts "Along the adventure, you will come along"
  puts "tools and keys as well as opportunities to collect money"
  puts "To view your backpack which holds these items,"
  puts "simply type \"backpack\""
  puts "If you are ready to begin, press enter"
  gets
  village
end

def village
  puts "\033[H\033[2JYou are in the village."
  puts "You can either go to the town shop, or venture into the forest"
  puts "1. Town shop"
  puts "2. Forest"
  print ">> "
  choice = gets.chomp
  if choice == "1"
    puts "You decide to go to the town shop"
    sleep(2)
    townShop
  elsif choice == "2"
    puts "You decide to venture into the forest"
    sleep(2)
    forest
  elsif choice == "backpack"
    $player.backpack
    village
  else
    puts "That is not an option, please try again"
    sleep 2
    village
  end
end

def townShop
  puts "\033[H\033[2JWelcome to the town shop"
  puts "\nYou currently have #{$player.addmoney(0)} coins"
  puts "Would you like to buy an item?"
  iters = 0
  while iters < $shopitems.length
    puts "#{iters + 1}. #{$shopitems[iters]} coins"
    iters += 1
  end
  puts "#{$shopitems.length + 1}. Exit"
  print "\n>> "
  choice = gets.chomp
  if choice.to_i == ($shopitems.length + 1)
    puts "Ok"
    sleep(1)
    print "\033[H\033[2J"
    village
  elsif choice == "1"
    puts "Just to confirm, you would like to buy the #{$shopitems[0]}? (Y/N)"
    print ">> "
    choice = gets.chomp.upcase
    if choice == "Y"
      $player.buyitem($shopitems[0], $shopitems[0].split(//).last(2).join.to_i)
      puts "You have #{$player.addmoney(0)} coins"
      sleep(1.5)
      townShop
    else
      puts "Purchase aborted"
      sleep(1)
      townShop
    end
  elsif choice == "2"
    if $shopitems.length > 1
      puts "Just to confirm, you would like to buy the #{$shopitems[1]}? (Y/N)"
      print ">> "
      choice = gets.chomp.upcase
      if choice == "Y"
        puts "You bought the #{$shopitems[1]}"
        $player.buyitem($shopitems[1], $shopitems[1].split(//).last(2).join.to_i)
        puts "You have #{$player.addmoney(0)} coins"
        sleep(1.5)
        townShop
      else
        puts "Purchase aborted"
        sleep(1)
        townShop
      end
    else
      puts "That is not an option, please try again"
      sleep(2)
      townShop
    end
  elsif choice == "backpack"
    $player.backpack
    townShop
  else
    puts "That is not an option, please try again"
    sleep 2
    townShop
  end
end

def forest
	puts "\033[H\033[2JIn the middle of the forest, you come to two trapdoors in the ground."
	puts "One of the trapdoors is blue, while the other is red."
	puts "Do you choose to go through the"
	puts
	puts "1. Blue Wooden Door"
	puts "2. Red Wooden Door"
  puts "3. Go back to the village"
	puts
	puts "Please respond with the number of your choice."
	door = gets.chomp
	puts

  if door == "1"
    if $player.showtools.include? "Axe"
      puts "You break the blue door open with your axe"
      puts "You enter a cave through the open trapdoor."
      puts "There's nothing here except a desk"
      if $hasbeentoblue
        puts "On the desk you find the same pen from earlier"
      else
        puts "On the desk you find a pen and 5 coins"
        $player.addmoney(5)
        $hasbeentoblue = true
      end
      puts "You exit the cave and go back to the surface"
      sleep 7 
      forest
    else
      puts "The door is locked"
      puts "You may need something to break it open"
      puts "Go back to the village? (Y/N)"
      print ">> "
      chosen = gets.chomp.upcase
      if chosen == "Y"
        puts "Going back to the village"
        sleep 2
        village
      elsif chosen == "N"
        puts "Staying in the forest"
        sleep 2
        forest
      else
        puts "That is not an option, please try again"
        sleep 2
        forest
      end
    end
  elsif door == "2"
    if $player.showtools.include? "Axe"
      puts "You break the red door open with your axe"
      puts "You enter a cave through the open trapdoor and find a dark tunnel."
      puts "You see three items inside the cave."
      puts "A candle on a ledge,"
      puts "A feather hanging from the ceiling,"
      puts "And a piece of paper on the ground."
      puts "What would you like to do?"
      puts
      puts "1. Pick up the candle."
      puts "2. Take the feather."
      puts "3. Read the piece of paper."
      puts
      puts "Please respond with the number of your choice."
      choice = gets.chomp
      puts
      if choice == "1"
        puts "You take the candle."
        puts "You look through the light down the tunnel"
        puts "And see discoloration on the far wall"
        puts "You walk through down the tunnel and see a message on the wall"
        puts "It reads, \“You made it.\”"
        puts "Far above, there is a medallion hanging from a nail"
        sleep 4 
        if $player.showtools.include? "Rope"
          puts "You use your rope to pull down the medallion"
          puts "It falls into your hands"
          puts "Congratulations, #{$player.name}, you are victorious"
          sleep 5
          puts "\033[H\033[2J\033[31m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[32m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[33m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[34m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[35m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[36m#{$winner}\033[0m"
          sleep(0.5)
          puts "\033[H\033[2J\033[37m#{$winner}\033[0m"
        else
          puts "You cannot reach the medallion."
          puts "Maybe there is some way you can bring it down"
          puts "Returning to the forest"
          sleep 5 
          forest
        end
      elsif choice == "3"
        puts "The piece of paper reads"
        puts "\"There is nothing here for you\""
        puts "You exit the cave"
        sleep 4
        forest
      elsif choice == "2"
        puts "In a hassle to grab the feather, you end up extinguishing"
        puts "The candle and you are left in darkness."
        puts "You are stuck in the cave forever"
      elsif choice == "backpack"
        $player.backpack
        forest
      else
        puts "That is not an option, please try again"
        forest
      end
    else
      puts "The door is locked"
      puts "You may need something to break it open"
      puts "Go back to the village? (Y/N)"
      print ">> "
      chosen = gets.chomp.upcase
      if chosen == "Y"
        puts "Going back to the village"
        sleep 2
        village
      elsif chosen == "N"
        puts "Staying in the forest"
        sleep 2
        forest
      else
        puts "That is not an option, please try again"
        sleep 2
        forest
      end
    end
  elsif door == "3"
    puts "Going back to the village"
    sleep 2
    village
  elsif door == "backpack"
    $player.backpack
    forest
  else
    puts "That is not an option, please try again"
    sleep 2
    forest
  end 
end

$titlescreen = '''
███╗   ███╗███████╗██████╗  █████╗ ██╗         ███████╗███████╗███████╗██╗  ██╗███████╗██████╗ 
████╗ ████║██╔════╝██╔══██╗██╔══██╗██║         ██╔════╝██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██╔████╔██║█████╗  ██║  ██║███████║██║         ███████╗█████╗  █████╗  █████╔╝ █████╗  ██████╔╝
██║╚██╔╝██║██╔══╝  ██║  ██║██╔══██║██║         ╚════██║██╔══╝  ██╔══╝  ██╔═██╗ ██╔══╝  ██╔══██╗
██║ ╚═╝ ██║███████╗██████╔╝██║  ██║███████╗    ███████║███████╗███████╗██║  ██╗███████╗██║  ██║
╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                                                               
'''

$winner = ''' _/      _/    _/_/    _/    _/      _/          _/  _/_/_/  _/      _/  _/   
  _/  _/    _/    _/  _/    _/      _/          _/    _/    _/_/    _/  _/    
   _/      _/    _/  _/    _/      _/    _/    _/    _/    _/  _/  _/  _/     
  _/      _/    _/  _/    _/        _/  _/  _/      _/    _/    _/_/          
 _/        _/_/      _/_/            _/  _/      _/_/_/  _/      _/  _/'''


start
