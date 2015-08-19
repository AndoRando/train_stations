require('spec_helper')

describe(Line) do
  describe('#name') do
    it("returns the name of the line") do
      test_line = Line.new({ :name => "Foo Line", :id => nil})
      expect(test_line.name).to eq("Foo Line")
    end
  end

  describe('.all') do
    it("returns all lines, empty at first") do
      expect(Line.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves line to the lines table in database') do
      test_line = Line.new({ :name => "Foo Line", :id => nil})
      test_line.save()
      expect(Line.all).to(eq([test_line]))
    end
  end

  describe('#==') do
    it('compares two line objects correctly') do
      test_line1 = Line.new({ :name => "Foo Line", :id => nil})
      test_line1.save
      test_line2 = Line.new({ :name => "Coast Starlight", :id => nil})
      test_line2.save
      expect(test_line1.==(test_line2)).to eq(false)
    end
  end

  describe('#delete') do
    it('removes a train line from the lines table') do
      test_line1 = Line.new({ :name => "Foo Line", :id => nil})
      test_line1.save
      test_line1.delete
      expect(Line.all).to(eq([]))
    end
  end

  describe(".find") do
    it("returns the line by its id") do
      test_line1 = Line.new({ :name => "Foo Line", :id => nil})
      test_line1.save
      test_line2 = Line.new({ :name => "Coast Starlight", :id => nil})
      test_line2.save
      expect(Line.find(test_line1.id)).to eq(test_line1)
    end
  end

  describe("#update") do
    it("updates the instance of line in the database") do
      test_line = Line.new({ :name => "Foo Line", :id => nil})
      test_line.save
      test_line.update({:name => "Bar Line"})
    end
  end

  # describe('#associate_station') do
  #   it('returns an array of associated stations') do
  #   test_line1 = Line.new({ :name => "Foo Line", :id => nil})
  #   test_line1.save
  #   test_station = Station.new({ :name => "Emancipation Station", :id => nil})
  #   test_station.save
  #   test_line1.associate_station(test_station)
  #   expect(test_line1.get_associated_stations).to(eq([test_station]))
  #   end
  # end
end
