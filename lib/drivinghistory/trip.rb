require 'time'

module DrivingHistory
  class Trip
    attr_reader(
      :start,
      :stop,
      :miles,
      :hours,
      :avg_mph
    )

    def initialize start, stop, miles
      @start = Time.parse(start.to_s)
      @stop = Time.parse(stop.to_s)
      @miles = miles.to_f
      
      @hours = (@stop - @start).to_f / 60 / 60
      @avg_mph = @miles / @hours
    end

    def ==(o)
      # override == so we can compare by value
      start == o.start &&
      stop == o.stop &&
      miles == o.miles
    end
  end
end