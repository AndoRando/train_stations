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
  erb(:who_are_you)
end

get('/home_rider') do
  @lines = Line.all()
  @stations = Station.all()
  erb(:home_rider)
end



get('/lines/:id') do
  @line = Line.find(params.fetch("id").to_i)
  @associated_stations = @line.get_associated_stations
  erb(:lines)
end

get('/stations/:id') do
  @station = Station.find(params.fetch("id").to_i)
  @associated_lines = @station.get_associated_lines

  erb(:stations)
end

get('/home_operator') do
  @lines = Line.all()
  @stations = Station.all()
  erb(:home_operator)
end

delete("/lines/:id") do
  @line = Line.find(params.fetch("id").to_i)
  @line.delete
  redirect '/home_operator'
end

delete("/stations/:id") do
  @station = Station.find(params.fetch("id").to_i)
  @station.delete
  redirect '/home_operator'
end

post("/add_line") do
  @line_name = params.fetch("line_new")
  @line = Line.new({:name => @line_name, :id => nil})
  @line.save
  redirect '/home_operator'
end

post("/add_station") do
  @station_name = params.fetch("station_new")
  @station = Station.new({:name => @station_name, :id => nil})
  @station.save
  redirect '/home_operator'
end
