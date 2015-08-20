require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('train stations path', {:type => :feature}) do
  it('has working dropdown menus') do
    test_line = Line.new({:name => 'Red Line', :id => nil})
    test_line.save()
    visit('/')
    click_link("riders_#{test_line.id()}")
    expect(page).to have_content('Red Line')
  end
end

describe('Operator adding a new line', {:type => :feature}) do
  it('allows an operator to add a new line, then view the line in the list of all lines') do
    visit('/')
    fill_in('line_id', :with => 'Purple Line')
    click_button('Add Line')
    click_link('Back Home')
    click_link('all_lines_operators')
    expect(page).to have_content('Purple Line')
  end
end

describe('Operator adding a new station', {:type => :feature}) do
  it('allows an operator to add a new station, then view the station in the list of all stations') do
    visit('/')
    fill_in('station_id', :with => 'Rosa Parks')
    click_button('Add Station')
    click_link('Back Home')
    click_link('all_stations_operators')
    expect(page).to have_content('Rosa Parks')
  end

end
