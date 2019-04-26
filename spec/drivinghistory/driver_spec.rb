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

  context 'with no trips' do
    describe '#avg_mph' do
      it 'is 0' do
        expect(driver.avg_mph).to eq(0)
      end
    end
  end

  context 'with 1 trip' do
    before(:example) do
      driver.add_trip('13:00', '14:30', 63)
    end
    
    describe '#avg_mph' do
      it 'calculates average miles per hour' do
        expect(driver.avg_mph).to eq(42)
      end
    end
  end

  context 'with multiple trips' do
    before(:example) do
      driver.add_trip('14:20', '14:40', 20)
      driver.add_trip('02:00', '05:00', 55)
      driver.add_trip('07:30', '15:25', 510)
    end

    describe '#avg_mph' do
      it 'calculates average miles per hour' do
        expect(driver.avg_mph).to eq(52)
      end
    end
  end
end