require 'csv'
require 'drivinghistory/driver'

module DrivingHistory
  module Engine
    def self.import driver_data
      drivers = {}

      CSV.foreach(driver_data, { :col_sep => "\s" }) do |row|
        command = row.shift
        name = row.shift

        case command
        when "Driver"
          drivers[name] = Driver.new(name)
        when "Trip"
          if drivers[name].nil? then
            STDERR.puts "Could not enter Trip data for #{name} as they have not been entered into the system as a Driver yet."
          else
            drivers[name].add_trip(*row)
          end
        end
      end
      drivers
    end

    def self.sort drivers, property
      case property
      when "total_miles_driven"
        drivers.sort_by { |key, driver| driver.total_miles_driven }.reverse
      when "total_hours_driven"
        drivers.sort_by { |key, driver| driver.total_hours_driven }.reverse
      when "name"
        drivers.sort_by { |key, driver| driver.name }
      else
        STDERR.puts "property '#{property}' is not a valid Driver property. Returning original unsorted hash."
        drivers
      end
    end

    def self.report drivers
      if drivers.empty?
        puts "No drivers found"
      else
        drivers.each do |key, driver|
          print "#{driver.name}: #{driver.total_miles_driven.round} miles"
          if driver.total_miles_driven > 0 then
            puts " @ #{driver.avg_mph.round} mph"
          else
            puts "" # output newline
          end
        end
      end
    end
  end
end