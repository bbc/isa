require 'rmagick'
require 'fileutils'

module ISA
  
  class Session
    
    attr_accessor :name, :tmp_dir, :dir, :code, :images, :checkpoint, :last_capture
    
    def initialize( args )
      @name = args[:session] || Time.now.to_i
      @code = args[:capture] or raise 'Need to provide a lambda to the constructor'
      @tmp_dir = "/tmp/isa/#{@name}"
      @dir = args[:dir] || @tmp_dir
      
      FileUtils.mkdir_p(@dir)
      FileUtils.mkdir_p(@tmp_dir)
      
      File.directory?(@dir) or raise "Couldn't create session directory for screen grabs"
      
      @images = Magick::ImageList.new
    end
 
    
    def capture(checkpoint = nil)
      
      if checkpoint
        @checkpoint = checkpoint
      end
      
      filename = (@checkpoint ? @checkpoint.to_s + '-' : '') + Time.now.to_i.to_s + '.png'
      
      file = "#{tmp_dir}/#{filename}"
      
      capture_time = Time.now
      code.call(file)
      
      File.exist? file or raise "Couldn't capture screenshot"
      
      image = Magick::ImageList.new(file).first
      
      if @last_capture
        delay = (capture_time - @last_capture).to_i
        images.last.delay = delay
      end
      @last_capture = capture_time
      
      images << image
      image
    end
    
    # Performs a capture and diffs it with the last image
    def diff
      if images.count == 0
        self.capture
      end
      
      last = images.last
      current = self.capture
      
      last.difference(current)[0].to_i
    end
    
    
    def end(filename = nil)
      if !filename
        filename = "#{@dir}/#{@name}.gif"
      else
        filename = "#{@dir}/#{@filename}"
      end
      images.ticks_per_second = 2
      puts "Writing to #{filename}"
      width = 750
      height = 750
      images.each {|i|  i.resize_to_fit!(width, height) }
      images.write(filename)
    end
    
    
  end
   
end
