require 'drivinghistory/trip'

RSpec.describe DrivingHistory::Trip.new("01:00", "04:00", 102) do
  it { is_expected.to have_attributes(:miles => 102) }
  it { is_expected.to have_attributes(:hours => 3) }
  it { is_expected.to have_attributes(:avg_mph => 34) }

  it "should have attribute start time" do
    expect(subject.start.strftime "%H:%M").to eq("01:00")
  end

  it "should have attribute stop time" do
    expect(subject.stop.strftime "%H:%M").to eq("04:00")
  end 
end