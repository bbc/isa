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

