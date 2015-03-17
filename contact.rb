require 'pry'

class Contact
 
  attr_accessor :first_name, :last_name, :email, :id, :phone_numbers
 
  @@contacts = []

  def initialize(first_name, last_name, email, phone_numbers)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone_numbers = phone_numbers
    @id = @@contacts.size + 1
  end

 
  def display
    "#{@first_name}, #{@ast_name[0]}. (#{@email})"
  end
 
  ## Class Methods
  class << self
    def create(first_name, last_name, email, phone_numbers = [])
      @@contacts << Contact.new(first_name, last_name, email, phone_numbers)
      # TODO: Will initialize a contact as well as add it to the list of contacts
    end
 
    def find(search_term)
      @@contacts.each do |contact|
        if contact.first_name.downcase.include? search_term.downcase
          puts contact.first_name.yellow
          puts contact.last_name.yellow
          puts contact.email.yellow
        end
      end

    end
 
    def all
      @@contacts
    end
    
    def show(id)
      contact = @@contacts.find {|contact| contact.id == id }
      if contact == nil 
        puts "Contact not found.".red
      else
        puts contact.first_name.yellow
        puts contact.last_name.yellow
        puts contact.email.yellow
      end
    end

    def duplicate_entries(entry)
      @@contacts.each do |contacts|
        if contacts.email == entry
          raise NameError, "That contact already exists and cannot be created."
        end
      end
    end
    
  end
 
end