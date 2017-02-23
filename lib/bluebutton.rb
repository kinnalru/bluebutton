require 'device_input'

class Bluebutton
  attr_accessor :on_keydown
  attr_accessor :on_keyup
  attr_accessor :on_longdown
  attr_accessor :on_longup

  def initialize name
    @finder = Finder.new(name)
    @device = @finder.from_sys

    raise "#{@device} is not a character device" unless File.chardev? @device
    raise "#{@device} is not readable. Try sudo" unless File.readable? @device
  end

  def run
    File.open(@device, 'rb' ) do |input|
      DeviceInput.read_loop(input) do |event|
        if event.type == 'EV_KEY'
          #puts event
          if event.value > 0
            key_down event
          else
            key_up event
          end
        end
      end
    end
  end

  def key_down event
    if @pressed.nil?
      @on_keydown.call if @on_keydown
      @pressed = Time.now
    elsif @long.nil? && @pressed < (Time.now - 1)
      @on_longdown.call if @on_longdown
      @long = true
    end
  end

  def key_up event
    if @pressed 
      @on_keyup.call if @on_keyup
      if @long 
        @on_longup.call if @on_longup
      end
    end
    @long = nil
    @pressed = nil
  end
end


class Finder
  def initialize name
    @name = name
  end

  def from_sys
    finded = Dir.glob("/sys/**/name").select do |file|
      File.read(file).downcase[@name.downcase]
    end.first

    raise "Can't find device info '#{@name}' in /sys/**/*" if finded.nil?

    device = "/dev/" + Dir.glob("#{File.dirname(finded)}/**/uevent").map do |file|
      File.read(file).split("\n").select{|s| s['DEVNAME']}.compact.first
    end.compact.flatten.first.split("=")[1] rescue nil

    raise "Can't find device file for '#{@name}' in #{File.dirname(finded)}/**/uevent" if device.nil?

    return device
  end
end


