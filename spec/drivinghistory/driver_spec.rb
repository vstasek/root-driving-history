require 'drivinghistory/driver'

RSpec.describe DrivingHistory::Driver.new("Bob") do
  it { is_expected.to have_attributes(:name => "Bob") }
  it { is_expected.to have_attributes(:trips => []) }
  it { is_expected.to have_attributes(:total_miles_driven => 0) }
  it { is_expected.to have_attributes(:total_hours_driven => 0) }
end