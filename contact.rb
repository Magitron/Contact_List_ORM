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
      puts result.inspect
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
    
    def find_by_email(email)
      result = nil 
      connection.exec_params("SELECT * FROM contacts WHERE email = $1;", [email]) do |contacts|
        contacts.each do |contact|
          result = Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
        end
      end
      puts result.inspect
    end

    def find_all_by_firstname(firstname)
      result_array = [] 
      connection.exec_params("SELECT * FROM contacts WHERE firstname = $1;", [firstname]) do |contacts|
        contacts.each do |contact|
          result_array << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
        end
      end
      puts result_array.inspect
    end

    def find_all_by_lastname(lastname)
      result_array = [] 
      connection.exec_params("SELECT * FROM contacts WHERE lastname = $1;", [lastname]) do |contacts|
        contacts.each do |contact|
          result_array << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
        end
      end
      puts result_array.inspect
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