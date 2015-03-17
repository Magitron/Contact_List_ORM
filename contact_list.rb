require 'colorize'
require_relative 'contact'


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

    puts "Please enter the first name".magenta
    firstname = STDIN.gets.chomp.capitalize

    puts "Please enter the last name".magenta
    lastname = STDIN.gets.chomp.capitalize

    contact = Contact.new(firstname, lastname, email)
    contact.save
    puts contact.inspect
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
    id = String(ARGV[1])
    Contact.find(id)
  when 'all'
    contacts = Contact.all
    # puts contacts.inspect
  when 'delete'
    id = String(ARGV[1])
    record = Contact.find(id)
    record.destroy
  end
end

