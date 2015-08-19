class Station
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:save) do
    temp = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
      @id = temp.first().fetch("id").to_i()
  end

  define_method(:==) do |another_station|
    self.name.==(another_station.name)
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stations WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |id|
    Station.all().each() do |station|
      if station.id == id
        return station
      end
    end
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = #{@id};")
  end

  # define_method(:associate_line) do |line|
  #   DB.exec("INSERT INTO stops (lines_id, stations_id) VALUES ('#{line.id}', '#{self.id}');")
  # end
  # 
  # define_method(:get_associated_lines) do
  #   lines_ids = DB.exec("SELECT lines_id FROM stops WHERE stations_id = #{self.id};")
  #   output_array = []
  #   lines_ids.each() do |hash|
  #     id = hash["lines_id"]
  #     output_array.push(Line.find(id))
  #   end
  #   output_array
  # end
end
