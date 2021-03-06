require 'isa/session'
require 'device_api/android'

serial = ARGV[0] or raise "Need to provide a serial number"

puts "SERIAL #{serial}"

device = DeviceAPI::Android.device(serial)

capture = ->(filename) {
  device.screenshot(:filename => filename)
}
  
  
session = ISA::Session.new( :name => 'adb-session', :capture => capture, :dir => 'captures' )
  
session.capture

10.times do
  puts session.diff
end

file = session.end

