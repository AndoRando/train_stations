require('spec_helper')

describe(Station) do
  describe('#name') do
    it("returns the name of the station") do
      test_station = Station.new({ :name => "Foo Station", :id => nil})
      expect(test_station.name).to eq("Foo Station")
    end
  end

  describe('.all') do
    it("returns all lines, empty at first") do
      expect(Station.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves station to the lines table in database') do
      test_station = Station.new({ :name => "Foo Station", :id => nil})
      test_station.save()
      expect(Station.all).to(eq([test_station]))
    end
  end

  describe('#==') do
    it('compares two station objects correctly') do
      test_station1 = Station.new({ :name => "Foo Station", :id => nil})
      test_station1.save
      test_station2 = Station.new({ :name => "Coast Starlight", :id => nil})
      test_station2.save
      expect(test_station1.==(test_station2)).to eq(false)
    end
  end

  describe('#delete') do
    it('removes a train station from the lines table') do
      test_station1 = Station.new({ :name => "Foo Station", :id => nil})
      test_station1.save
      test_station1.delete
      expect(Station.all).to(eq([]))
    end
  end

  describe(".find") do
    it("returns the station by its id") do
      test_station1 = Station.new({ :name => "Foo Station", :id => nil})
      test_station1.save
      test_station2 = Station.new({ :name => "Coast Starlight", :id => nil})
      test_station2.save
      expect(Station.find(test_station1.id)).to eq(test_station1)
    end
  end

  describe("#update") do
    it("updates the instance of station in the database") do
      test_station = Station.new({ :name => "Foo Station", :id => nil})
      test_station.save
      test_station.update({:name => "Bar Station"})
      expect(test_station.name).to(eq("Bar Station"))
    end
  end

#   describe('#associate_line') do
#     it('returns an array of associated lines') do
#     test_line1 = Line.new({ :name => "Foo Line", :id => nil})
#     test_line1.save
#     test_station = Station.new({ :name => "Emancipation Station", :id => nil})
#     test_station.save
#     test_station.associate_line(test_line1)
#     expect(test_station.get_associated_lines).to(eq([test_line1]))
#   end
# end
#
#   describe("#get_associated_lines") do
#     it('returns an array of associated lines') do
#       test_line1 = Line.new({ :name => "Foo Line", :id => nil})
#       test_line1.save
#       test_line2 = Line.new({ :name => "Bar Line", :id => nil})
#       test_line2.save
#       test_station = Station.new({ :name => "Emancipation Station", :id => nil})
#       test_station.save
#       test_station.associate_line(test_line1)
#       test_station.associate_line(test_line2)
#       expect(test_station.get_associated_lines).to(eq([test_line1, test_line2]))
#     end
#   end
end
