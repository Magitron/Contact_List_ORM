require 'colorize'
require_relative 'contact'


class Application

  def run
      case ARGV[0]
    when 'help'
      help
    when 'new'
      prompt_new
    when 'find'
      find
    when 'all'
      contacts = Contact.all
    when 'delete'
      delete
    when 'email'
      email
    when 'firstname'
      firstname
    when 'lastname'
      lastname
    end
  end

  def help
    puts "Here is a list of available commands:".red
    puts "new  - Create a new contact".blue
    puts "list - List all contacts".blue
    puts "show - Show a contact".blue
    puts "find - Find a contact".blue
  end

  def prompt_new
    puts "Please enter an email".magenta
    email = STDIN.gets.chomp.downcase

    puts "Please enter the first name".magenta
    firstname = STDIN.gets.chomp.capitalize

    puts "Please enter the last name".magenta
    lastname = STDIN.gets.chomp.capitalize

    contact = Contact.new(firstname, lastname, email)
    contact.save
    puts contact.inspect
  end

  def find
    id = String(ARGV[1])
    Contact.find(id)
  end

  def delete
    id = String(ARGV[1])
    record = Contact.find(id)
    record.destroy
  end

  def email
    email = String(ARGV[1])
    contact = Contact.find_by_email(email)
  end

  def firstname
    firstname = String(ARGV[1])
    contacts = Contact.find_all_by_firstname(firstname)
  end

  def lastname
    lastname = String(ARGV[1])
    contacts = Contact.find_all_by_lastname(lastname)
  end
end

program = Application.new
program.run
