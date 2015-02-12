#ISA -- Image Session Analyzer

Helpers for grabbing screenshots over a time period, analyzing them, and stitching them together for later playback.

## Usage

    capture = ->(filename) {
      device.screenshot(filename) 
    }
    
    session = ISA::Session.new( :name   => 'session_1',
                                :assets => 'asset_directory',
                                :lambda => capture )
    
    session.capture( :checkpoint_1 )
    
    sleep 5    
    
    session.capture( :checkpoint_2 )
    
    comp = session.compare( :checkpoint_1, :checkpoint_2 )

    
