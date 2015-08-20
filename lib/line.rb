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
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  # define_method(:associate_station) do |station|
  #   DB.exec("INSERT INTO stops (lines_id, stations_id) VALUES ('#{self.id}', '#{station.id}');")
  # end
  #
  # define_method(:get_associated_stations) do
  #   stations_ids = DB.exec("SELECT * FROM stops WHERE lines_id = #{self.id};")
  #   output_array = []
  #   stations_ids.each() do |hash|
  #     id = hash["stations_id"]
  #     output_array.push(Station.find(id)[0])
  #   end
  #   output_array
  # end
end
