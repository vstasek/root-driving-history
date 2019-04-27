How to run
----
The access point to the program is located at bin/root-driving-history. root-driving-history accepts input via a file name argument given on the command line. I added a few sample .txt input files to spec/fixtures for easy testing purposes.

Example Call: ruby bin/root-driving-history spec/fixtures/driver_input.txt


Features of program explained
----
root-driving-history:
  Primarily makes calls to class methods in the DrivingHistory::Engine Module. These class methods handle all the high-level manipulation of the input file's data (importing (.import), sorting (.sort), and generating the final report (.report)).

DrivingHistory::Engine.import:
  Takes 1 parameter, the file name given on the command line. It uses the Ruby 'csv' library to iterate over the file. All the data needed for the final report is encapsulated in 2 classes, DrivingHistory::Driver and DrivingHistory::Trip. When reading in the file, on command "Driver" it creates a new Driver instance and add it to the 'drivers' hash with a string of the Driver's name as the key and the Driver object as the value. On command "Trip", I call Driver.add_trip() (explained in more detail below).

Driver Class:
  The #add_trip instance method adds a Trip to the Driver's trip [] property. One nice perk of this architecture is that users of the Driver class don't need to have any knowledge of the Trip class. All details of that class's existence are hidden behind the add_trip implementation. As it add Trips to a Driver instance, we can easily keep track of the Driver's total_miles_driven & total_hours_driven so that we can very easily access that data for sorting and calculate each Driver's average mph for the final report.

Trip Class:
  Trip is a fairly sparse class with no methods. I debated simply storing each Trip as a simple hash instead, but storing it in a class made the data easier to work with and reason about. Using a class also makes it easier to automatically calculate the hours and avg_mph properties in the initializer for later use.

Engine.sort():
  Takes 2 parameters: the hash to be sorted and the property of Driver we want to sort by. I could've just had it sort by total_miles_driven per the prompt requirements, but I wanted it to have more flexibility so we could sort by ANY property of the Driver class if desired. For now, I had to settle for passing the 2nd parameter as a string and make a call to sort_by once for each property. Ideally, there's a way to pass a property of the Driver class generically so I wouldn't need a case statement, but I couldn't figure out how to do that in Ruby.. (any advice on how to accomplish this? lol)
  
  One last detail to note about Engine.sort: sorting a hash requires you to convert the hash to a 2D array. Our "drivers" hash is thus converted to a 2D array at this point. This made me consider making the drivers hash a 2D array from the start. However, I decided to keep the hash for the .import() process so I wouldn't have to search the entire array for the specified Driver each time we added a new Trip. Hashes are much faster for lookups.
  
Engine.report():
  Since our data is now encapsulated and sorted appropriately, it's fairly easy to iterate over the drivers Array and output the data in the format we want. Originally, I had the sorting functionality inside the .report() method, but decided that .report() had too many responsiblities at that point.