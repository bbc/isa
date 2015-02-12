require 'isa/session'
require 'device_api/android'

serial = ARGV[0] or raise "Need to provide a serial number"

puts "SERIAL #{serial}"

device = DeviceAPI::Android.device(serial)

capture = ->(filename) {
  device.screenshot(:filename => filename)
}
  
  
session = ISA::Session.new( :name => 'adb-session', :capture => capture, :dir => 'captures' )
  
frame = session.capture
reference = frame

100.times do
  array = reference.difference(frame)
  puts session.diff
end

file = session.end

