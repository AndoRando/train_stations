require('pg')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/line')
require('./lib/station')
require('pry')
require('capybara')

DB = PG.connect({:dbname => 'train'})

get('/') do
  @lines = Line.all()
  @stations = Station.all()
  # @stops = Stop.all()
  erb(:index)
end

###### LINES

get('/lines/:id') do
  @line = Line.find(params.fetch('id'))
  erb(:line)
end

get('/lines') do
  @lines = Line.all()
  erb(:lines)
end

post('/lines') do
  name = params.fetch('line_id')
  line = Line.new({:name => name, :id => nil})
  line.save()
  erb(:success)
end

# patch('/lines/:id') do
# name = params.fetch('line_id')
# line = Line.new({:name => name, :id => nil})
# line.save()
#   erb(:success)
# end
#
# delete('/lines/:id') do
#   erb(:success)
# end

###### STATIONS

get('/stations/:id') do
  @station = Station.find(params.fetch('id'))
  erb(:station)
end

get('/stations') do
  @stations = Station.all()
  erb(:stations)
end

post('/stations') do
  name = params.fetch('station_id')
  station = Station.new({:name => name, :id => nil})
  station.save()
  erb(:success)
end

# patch('/stations/:id') do
#   erb(:success)
# end
#
# delete('/stations/:id') do
#   erb(:success)
# end

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
