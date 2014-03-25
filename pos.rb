require 'active_record'
require './lib/cashier'
require './lib/purchase'
require './lib/order'
require './lib/inventories'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the pos system"
  main_menu
end

def main_menu
  puts "Press 'm' to go to the manager menu"
  puts "Press 'e' to go to the employee menu"
  puts "Press 'x' to exit"
  input = gets.chomp
  case input
  when 'm'
    manager
  when 'e'
    employee_menu
  when 'x'
    puts "Goodbye!"
  else
    puts "That is not a valid option"
  end
end

def manager
  puts "Press 'o' to order new inventory"
  puts "Press 'v' to view current inventory"
  puts "Press 'a' to add a cashier"
  puts "Press 'l' to list current cashiers"
  puts "Press 'b' to go back to main menu"
  input = gets.chomp
  case input
  when 'o'
    order
  when 'v'
    current_inventory
  when 'a'
    add_cashier
  when 'l'
    view_cashiers
  when 'b'
    main_menu
  else
    puts "That is not a valid option"
  end
end

def order
  puts "Enter the item you wish to order"
  item_name = gets.chomp
  puts "Enter the quanity of #{item_name}"
  item_quanity = gets.chomp.to_i
  puts "Enter the price you wish to sell at"
  item_price = gets.chomp.to_f
  Inventories.create({:name => item_name, :price => item_price, :quanity => item_quanity})
  puts "Your order has been updated"
  manager
end

def current_inventory
  puts "Here is a list of everything in your inventory"
  Inventories.all.each { |inventory| puts inventory.name + ": quanity:" + inventory.quanity.to_s + " price:" + inventory.price.to_s}
  manager
  end



def employee_menu
  puts "Press 't' to make a new transaction"
  puts "Press 'r' to see receipts"
  puts "Press 'b' to go back"
  input = gets.chomp
  case input
  when 't'
    new_purchase
  when 'r'
    receipts
  when 'b'
    main_menu
  else
    puts "That is not a valid option"
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
    puts "Goodbye!"
  else
    puts "That is not a valid option"
  end
end

def new_purchase
  puts "Enter the cashier id:"
  Cashier.all.each_with_index do |cashier, index|
    puts "#{index+1}. #{cashier.name}"
  end
  input = gets.chomp.to_i
  cashier_id = Cashier.find(input)
  new_purchase_item_id(cashier_id)
end

def new_purchase_item_id(cashier_id)
  puts "Enter the id of the item being sold"
  Inventories.all.order(:id).each do |inventory|
    puts "#{inventory.id}. #{inventory.name}"
  end
    input = gets.chomp.to_i
    inventory_id = Inventories.find(input)
    puts "How many of the item is being sold?"
    item_quanity = gets.chomp.to_i
    inventory_count(cashier_id, inventory_id, item_quanity)
end

def inventory_count(cashier_id, inventory_id, item_quanity)

  puts cashier_id.name + " " + inventory_id.name
  new_quanity = inventory_id.quanity - item_quanity
  inventory_id.update({:quanity => new_quanity})
  puts inventory_id.quanity
  puts "Would you like to purchase another item? 'y' or 'n'"
  input = gets.chomp
  case input
  when 'y'
    new_purchase_item_id
  when 'n'
    calculate
  else
    puts "That is not a valid option"
  end
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
  manager
end

def view_cashiers
  puts "Here are all the cashiers in the system:"
  Cashier.all.each_with_index do |cashier, index| puts "#{index +1}. #{cashier.name}"
  end
  manager
end



welcome
