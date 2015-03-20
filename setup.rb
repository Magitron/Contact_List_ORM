# require_relative 'contact'
require 'active_record'

puts "Establishing connection to database..."

ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    encoding: 'unicode',
    pool: 5,
    database: 'd1qtsk1ten3dsu',
    username: 'hlwuyqroaunjey',
    password: '9XQ6oyS1ZIQiwNjbrcqRb4lDmz',
    host: 'ec2-107-22-253-198.compute-1.amazonaws.com',
    port: 5432,
    min_messages: 'error'
  )



  # ActiveRecord::Base.establish_connection(creds)
  puts "CONNECTED"