## TODO: Implement CSV reading/writing
require 'csv'


class ContactDatabase #responsible for reading and writing this file
 
   class << self
    def write_contacts
      CSV.open('contacts.csv', 'w') do |new_contact|
        Contact.all.each do |contact|
          contact_array = [contact.first_name, contact.last_name, contact.email]
          contact.phone_numbers.each do |phone_number|
            contact_array << "#{phone_number[:label]}:#{phone_number[:number]}"
          end
          new_contact << contact_array
       end
      end
    end

    def read_contacts
      CSV.foreach('contacts.csv') do |row|
        phone_numbers = []
        if row.length > 3
          for i in 3..(row.length-1)
            phone_number = {}
            phone_number_parts = row[i].split(":", 2)
            phone_number[:label] = phone_number_parts[0]
            phone_number[:number] = phone_number_parts[1]
            phone_numbers << phone_number
          end
        end
        Contact.create(row[0], row[1], row[2], phone_numbers) 
      end
    end
  end
end




