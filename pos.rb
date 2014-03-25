require 'active_record'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the pos system"
  main
end

def main
  puts "Press 'c' to go to the cashiers menu"
  puts "Press 's' to go to the sales menu"
  puts "Press 'x' to leave the system"
  input = gets.chomp
  case input
  when 'c'
    cashiers
  when 's'
    sales
  when 'x'
    puts "Goodbye!"
  else
    puts 'That is not a valid option'
  end
end

def cashiers
  puts "Press 'a' to add a cashier"
  puts "Press 'v' to view cashiers"
  puts "Press 'b' to go back"
  puts "Press 'x' to exit"
  input = gets.chomp
  case input
  when 'a'
    add_cashier
  when 'v'
    view_cashiers
  when 'b'
    menu
  when 'x'
    puts "Goodbye!"
  else
    puts "That is not a valid option."
  end
end

def add_cashier
  puts "Enter the name of the cashier you would like to add:"
  new_cashier = gets.chomp
  new_cashier.save
  puts "'#{new_cashier}' has been added to the system."
  puts "'Would you like to go back to the main menu? 'y' or 'n'"
  input = gets.chomp
  case input
  when 'y'
    menu
  when 'n'
    puts 'Goodbye!'
  else
    puts "That is not a valid option."
  end
end

def view_cashiers
  puts "Here are all the cashiers in the system:"
  end



welcome
