require 'active_record'
require './lib/cashier'
require './lib/purchase'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the pos system"
  main
end

def main
  puts "Press 'c' to go to the cashiers menu"
  puts "Press 'p' to go to the purchases menu"
  puts "Press 'x' to leave the system"
  input = gets.chomp
  case input
  when 'c'
    cashiers
  when 'p'
    purchases
  when 'x'
    puts "Goodbye!"
  else
    puts 'That is not a valid option'
  end
end

def purchases
  puts "Press 'n' to enter a new purchase"
  puts "Press 'l' to list all purchases"
  puts "press 'x' to leave the system"
  input = gets.chomp
  case input
  when 'n'
    new_purchase
  when 'l'
    list_purchases
  when 'x'
    puts "Goodby!"
  else
    puts "That is not a valid option"
  end
end

def new_purchase
  Cashier.all.each_with_index do |cashier, index| puts "#{index+1}. #{cashier.name}"
  end
  puts "Enter the cashier id:"
  input = gets.chomp.to_i
  cashier_id = Cashier.all[input-1].id
  puts "Enter item name"
  new_item = gets.chomp
  puts "Enter price"
  new_item_price = gets.chomp.to_f
  new_purchase = Purchase.new({:name => new_item, :price => new_item_price, :cashier_id => cashier_id})
  new_purchase.save
  puts "#{new_item} has been purchased for $#{new_item_price}"
  main
end

def list_purchases
  puts "Select a purchase to view its cashier"
  Purchase.all.each_with_index do |purchase, index|
    puts "#{index+1}. #{purchase.name}"
  end
  selected_purchase = gets.chomp.to_i
  selected_cashier_id = Purchase.find(selected_purchase)
  puts selected_cashier_id.name + ": " + selected_cashier_id.cashier.name
  main
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
  cashier_name = gets.chomp
  new_cashier = Cashier.new({:name => cashier_name})
  new_cashier.save
  puts "'#{cashier_name}' has been added to the system."
  puts "'Would you like to go back to the main menu? 'y' or 'n'"
  input = gets.chomp
  case input
  when 'y'
    main
  when 'n'
    puts 'Goodbye!'
  else
    puts "That is not a valid option."
  end
end

def view_cashiers
  puts "Here are all the cashiers in the system:"
  Cashier.all.each_with_index do |cashier, index| puts "#{index +1}. #{cashier.name}"
  end
  puts "\n\n"
  puts "Would you like to go back to the main menu? 'y' 'n'"
  input = gets.chomp
  case input
  when 'y'
    main
  when 'n'
    puts "Goodbye"
  else
    puts "That is not a valid entry"
  end
end



welcome
