#ISA -- Image Session Analyzer

Helpers for grabbing screenshots over a time period, analyzing them, and stitching them together for later playback.

## Usage

    capture = ->(filename) {
      device.screenshot(:filename => filename)
    }
    
    session = ISA::Session.new( :name => 'adb-session', :capture => capture, :dir => 'captures' )
    
    frame = session.capture

    10.times do
      puts session.diff
    end

    file = session.end( './composite.gif' )
    

## License

ISA is available to everyone under the terms of the MIT open source licence. Take a look at the LICENSE file in the code.

Copyright (c) 2015 BBC

