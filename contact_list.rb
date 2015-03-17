require 'colorize'
require_relative 'contact'
require_relative 'contact_database'


class Application

  case ARGV[0]
  when 'help'
    puts "Here is a list of available commands:".red
    puts "new  - Create a new contact".blue
    puts "list - List all contacts".blue
    puts "show - Show a contact".blue
    puts "find - Find a contact".blue
  when 'new'
    puts "Please enter an email".magenta
    email = STDIN.gets.chomp.downcase
    ContactDatabase.read_contacts
    Contact.duplicate_entries(email)

    puts "Please enter the first name".magenta
    first_name = STDIN.gets.chomp.capitalize

    puts "Please enter the last name".magenta
    last_name = STDIN.gets.chomp.capitalize

    phone_numbers = []
    puts "Would you like to enter a phone number? (y/n)".magenta
    choice = STDIN.gets.chomp
    while choice == 'y'
      new_phone_number = {}
      puts "Mobile or Home?"
      new_phone_number[:label] = STDIN.gets.chomp.capitalize
      puts "Enter number"
      new_phone_number[:number] = STDIN.gets.chomp
      phone_numbers << new_phone_number
      puts "Would you like to enter another phone number? (y/n)"
      choice = STDIN.gets.chomp
    end
    p Contact.create(first_name, last_name, email, phone_numbers)
    ContactDatabase.write_contacts
  when 'list'
    ContactDatabase.read_contacts
    Contact.all.each do |contact|
    puts "##{contact.id}: #{contact.first_name}, #{contact.last_name[0]} (#{contact.email})".green
    end
  when 'show'
    ContactDatabase.read_contacts
    id = Integer(ARGV[1]) #if its not a valid intiger it throws an argument
    Contact.show id
  when 'find'
    ContactDatabase.read_contacts
    search_term = String(ARGV[1])
    Contact.find search_term
  end
end

