require('rspec')
require('line')
require('station')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'train_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    # DB.exec("DELETE FROM stops *;")
  end
end
