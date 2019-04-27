require 'drivinghistory/engine'
require 'drivinghistory/driver'

RSpec.describe DrivingHistory::Engine do
  let(:test_file_path) { File.dirname(__FILE__) + '/../fixtures/driver_input.txt' }

  let(:alex) { DrivingHistory::Driver.new("Alex") }
  let(:dan) { DrivingHistory::Driver.new("Dan") }
  let(:bob) { DrivingHistory::Driver.new("Bob") }

  before(:example) do
    dan.add_trip("07:15", "07:45", "17.3")
    alex.add_trip("12:01", "13:16", "42.0")
    dan.add_trip("06:12", "06:32", "21.8")
  end

  describe '.import' do
    let(:result) {{ "Alex" => alex, "Dan" => dan, "Bob" => bob }}

    it "should parse file contents and return a result" do
      expect(subject.import(test_file_path)).to eq(result)
    end
  end

  describe '.sort' do
    let(:drivers) {subject.import(test_file_path)}

    context "name" do
      let(:result) { [["Alex", alex], ["Bob", bob], ["Dan", dan]] }
      
      it "should sort driver by name" do
        expect(subject.sort(drivers, "name")).to eq(result)
      end
    end

    context "total_miles_driven" do
      let(:result) { [["Alex", alex], ["Dan", dan], ["Bob", bob]] }

      it "should sort drivers by total_miles_driven" do
        expect(subject.sort(drivers, "total_miles_driven")).to eq(result)        
      end
    end
  end
end