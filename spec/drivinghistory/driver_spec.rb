require 'drivinghistory/driver'

RSpec.describe DrivingHistory::Driver.new("Bob") do
  it { is_expected.to have_attributes(:name => "Bob") }
  it { is_expected.to have_attributes(:trips => []) }
  it { is_expected.to have_attributes(:total_miles_driven => 0) }
  it { is_expected.to have_attributes(:total_hours_driven => 0) }
end

RSpec.describe DrivingHistory::Driver do
  subject(:driver) do
    described_class.new("Dave")
  end

  describe '#add_trip' do
    context "Trip's avg mph > 5 and < 100" do
      it "adds a Trip to Driver's trip array" do
        expect { driver.add_trip('05:20', '05:40', 20) }.to change { driver.trips.length }.from(0).to(1)
      end
    end

    context "Trip's avg mph < 5" do
      it "does not add Trip to Driver's trip array" do
        expect { driver.add_trip('05:00', '09:00', 5) }.to_not change { driver.trips.length }
      end
    end

    context "Trip's avg mph > 100" do
      it "does not add Trip to Driver's trip array" do
        expect { driver.add_trip('05:00', '09:00', 1000) }.to_not change { driver.trips.length }
      end
    end
  end
end