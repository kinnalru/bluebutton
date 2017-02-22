#!/usr/bin/ruby

require 'device_input'

DEFAULT_BUTTON_NAME="AB Shutter3"


class Bluebutton
  attr_accessor :on_key_down
  attr_accessor :on_key_up
  attr_accessor :on_long_down
  attr_accessor :on_long_up

  def initialize name
    @finder = Finder.new(name)
    @device = @finder.from_sys
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
      @on_key_down.call if @on_key_down
      @pressed = Time.now
    elsif @long.nil? && @pressed < (Time.now - 1)
      @on_long_down.call if @on_long_down
      @long = true
    end
  end

  def key_up event
    if @pressed 
      @on_key_up.call if @on_key_up
      if @long 
        @on_long_up.call if @on_long_up
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
      File.read(file)[@name]
    end

    return "/dev/" + finded.map do |file|
      Dir.glob("#{File.dirname(file)}/**/uevent").map do |file|
        File.read(file).split("\n").select{|s| s['DEVNAME']}.compact.first
      end.compact
    end.flatten.first.split("=")[1]

  rescue nil
  end
end


button = Bluebutton.new(DEFAULT_BUTTON_NAME)

button.on_key_down = -> do
  puts "Key pressed"
end

button.on_key_up = -> do
  puts "Key released"
end

button.on_long_down = -> do
  puts "Long press"
end

button.on_long_up = -> do
  puts "Long released"
end

button.run




