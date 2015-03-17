require 'pg'
require 'pry'


puts "establishing connection..."

class Contact
 
  attr_accessor :first_name, :last_name, :email
  attr_reader :id

  def initialize(firstname, lastname, email, id = nil)
    @firstname = firstname
    @lastname = lastname
    @email = email
    # @phone_numbers = phone_numbers
    @id = id
  end


  def self.connection
    return @conn if @conn
    @conn = PG.connect(
      dbname: 'd1qtsk1ten3dsu',
      port: 5432,
      user: 'hlwuyqroaunjey',
      host: 'ec2-107-22-253-198.compute-1.amazonaws.com',
      password: '9XQ6oyS1ZIQiwNjbrcqRb4lDmz'
  )
  end

    def save
      if @id == nil
        result = self.class.connection.exec_params("INSERT INTO contacts (firstname, lastname, email) VALUES ('#{@firstname}', '#{@lastname}', '#{@email}') returning id")
        @id = result[0]['id']
      else
        self.class.connection.exec_params('UPDATE pets SET firstname = $1 lastname = $2 email = $3  WHERE id = $4;', [@firstname, @lastname, @email, @id])
      end
    end

    def destroy
      self.class.connection.exec_params("DELETE FROM contacts WHERE id = $1;", [id])
    end


  class << self
    def find(id)
      result = nil
      connection.exec_params("SELECT * FROM contacts WHERE id = $1;", [id]) do |results|
        results.each do |row|
          result = Contact.new(
            row['firstname'],
            row['lastname'],
            row['email'],
            row['id']
            )
        end
      end
      result
      # puts "Closing the db connection..."
    end
 
    def all
    puts "getting contacts ..."
      connection.exec( "SELECT * FROM contacts" ) do |results|
        # results is a collection (array) of records (hashes)... Nice!
        results.each do |contact|
          puts contact.inspect
        end
        puts "Closing the db connection..."
      end
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