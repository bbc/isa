![ISA](http://bbc.github.io/hive-ci/images/isa-logo.png)

#ISA -- Image Session Analyser

Helpers for grabbing screenshots over a time period, analyzing them, and
stitching them together for later playback.

We largely use ISA for checking video playback on our device tests.

## Why would you use it?

We run a lot of tests that capture screenshots. Often we'll take several
screenshots over the duration of a test and we wanted some way of comparing
the captures over the test run in order to determine if video playback is
working.

ISA performs a diff between screenshots and returns an integer representing
the amount of change between screenshots. A value of zero indicates the
screenshots are identical. Wheras a value in the thousands indicates a large
differential between the images. We find this diff technique gives us a
good indication that video is playing in our tests, and will also spot
buffering problems and crashes (the diff value drops significantly).

ISA also stitches together the screenshots its taken over a session to create
an animated gif that is a handy reference for checking why a particular test
failed.

## Dependencies

The gem is very simple and doesn't do any capture itself -- you'll need to
have some mechanism for doing that yourself. We use the device_api gem for
grabbing screenshots from physical android and ios devices.

The gem uses [ImageMagick](http://www.imagemagick.org/) to perform the
screenshot comparisons -- you will need to install this dependency first.

## Usage example

You first need to define a lambda for creating a screenshot. For example,
using the device_api we might do:

    take_screenshot = ->(filename) {
      device.screenshot(:filename => filename)
    }
    
You can then use that lambda with ISA to establish a capture session,
giving it a directory where you want the screen shots.
    
    session = ISA::Session.new( :name => 'test-01', :capture => take_screenshot, :dir => 'captures' )
    
    # Call capture for the initial screenshot
    frame = session.capture

    # session.diff performs a screenshot and does the diff
    10.times do
      puts session.diff
    end

    # Finish the session and create the composite
    file = session.end( './composite.gif' )
    
## License

ISA is available to everyone under the terms of the MIT open source licence. Take a look at the LICENSE file in the code.

Copyright (c) 2015 BBC

