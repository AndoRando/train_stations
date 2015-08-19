require('pg')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/line')
require('./lib/station')
require('pry')
require('capybara')

DB = PG.connect({:dbname => 'trains'})

get('/') do
  erb(:index)
end

###### LINES

get('/line/:id') do
  erb(:line)
end

get('/lines') do
  erb(:lines)
end

post('/lines') do
  erb(:success)
end

###### STATIONS

get('/station/:id') do
  erb(:station)
end

get('stations') do
  erb(:stations)
end

post('/stations') do
  erb(:success)
end

###### STOPS

# get('/stop/:id') do
#   erb(:)
# end
#
# get('/stops') do
#   erb(:)
# end
#
# post('/stops') do
#   erb(:)
# end
