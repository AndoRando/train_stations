require('pry')

class Line
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:save) do
    temp = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = temp.first().fetch("id").to_i()
  end

  define_method(:==) do |another_line|
    self.name.==(another_line.name)
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lines WHERE id = #{@id}")
  end

  define_singleton_method(:find) do |id|
    found_line = nil
    Line.all().each() do |line|
      if line.id() == id
        found_line = line
      end
    end
    found_line
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:station_ids, []).each() do |station_id|
      DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{station_id}, #{self.id()});")
    end
  end

  define_method(:stations) do
    line_stations = []
    results = DB.exec("SELECT station_id FROM stops WHERE line_id = #{self.id()};")
    results.each() do |result|
      station_id = result.fetch('station_id').to_i()
      station = DB.exec("SELECT * FROM stations WHERE id = #{station_id};")
      name = station.first().fetch('name')
      line_stations.push(Station.new({:name => name, :id => station_id}))
    end
    line_stations
  end
end
