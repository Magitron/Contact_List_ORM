require 'colorize'
require_relative 'contact'
require_relative 'setup'


class Application

  def run
    case ARGV[0]
    when 'help'
      help
    when 'new'
      prompt_new
    when 'find'
      find_by_id
    when 'all'
      all
    when 'delete'
      delete
    when 'email'
      find_by_email
    when 'firstname'
      find_all_by_firstname
    when 'lastname'
      find_all_by_lastname
    else
      help
    end
  end

  def display(contact)
    puts 'ID: ' + contact.id.to_s.magenta
    puts 'Firstname: ' + contact.firstname.magenta
    puts 'Lastname: ' + contact.lastname.magenta
    puts 'Email: ' + contact.email.magenta
    puts ''
  end

  def find_by_id
    id = String(ARGV[1])
    display(Contact.find(id))
  end


  def find_by_email
    email = String(ARGV[1])
    contact = Contact.find_by email: email
    if contact.nil? then puts "Contact not found".red 
    else display(contact)
    end
  end

  def find_all_by_firstname
    firstname = String(ARGV[1])
    contacts = Contact.where(firstname: firstname)
    if contacts.empty? then puts "Contact not found".red 
    else contacts.each do |contact|
          display(contact)
        end
    end
  end

  def find_all_by_lastname
    lastname = String(ARGV[1])
    contacts = Contact.where(lastname: lastname)
    if contacts.empty? then puts "Contact not found".red 
    else contacts.each do |contact|
          display(contact)
        end
    end
  end

  def delete
    id = String(ARGV[1])
    record = Contact.find(id)
    puts "Are you sure you want to delete this record? (y/n)".red
    display(record)
    answer = STDIN.gets.chomp
    record.destroy if answer == 'y'
    puts "The record has been deleted".red
  end

  def all
    contacts = Contact.all
    contacts.each do |contact|
      display(contact)
    end
  end

  def help
    puts "Here is a list of available commands:".red
    puts "new  - Create a new contact".blue
    puts "all - List all contacts".blue
    puts "id - Find a contact by id".blue
    puts "email - Find a contact by email".blue
    puts "firstname - Find a contact by firstname".blue
    puts "lastname - Find a contact by lastname".blue
    puts "delete - Delete a contact".blue
  end

  def prompt_new
    puts "Please enter an email".magenta
    email = STDIN.gets.chomp.downcase

    puts "Please enter the first name".magenta
    firstname = STDIN.gets.chomp.capitalize

    puts "Please enter the last name".magenta
    lastname = STDIN.gets.chomp.capitalize

    contact = Contact.create(firstname: firstname, lastname: lastname, email: email)
    puts "Contact created!".green
    display(contact)
  end

end
program = Application.new
program.run