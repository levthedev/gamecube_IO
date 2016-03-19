require 'socket'
require_relative "neutral"
require_relative "pipe"

class Memreader
  include Neutral
  include Pipe

  def initialize
    @@state = {}
    @@osx_path = "#{ENV["HOME"]}/Library/Application\ Support/Dolphin/"
    begin
      create_socket
    rescue => e
      `rm ~/Library/Application\\ Support/Dolphin/MemoryWatcher/MemoryWatcher` unless ARGV[0]
      create_socket
    end
  end

  def create_socket
    @sock = Socket.new(:AF_UNIX, :DGRAM)
    if ARGV[0]
      path = ARGV[0] + "MemoryWatcher/MemoryWatcher"
    else
      path = @@osx_path + "MemoryWatcher/MemoryWatcher"
    end
    @sock.bind(Socket.sockaddr_un(path))
  end

  def monitor
    loop do
      line = @sock.gets
      output = line.split(/\u0000/)
      update_globals(output)
      evaluate_neutral(@@state)
    end
  end

  def update_globals(output)
    if output.length == 2
      value = output.first
      address = output.last.chomp
      update_address_value(address, value)
    else
      puts "#{output.to_s} was too short"
    end
  end

  def update_address_value(address, value)
    case address
      when "80453090" then @@state["p1_x"] = hex_to_float(value)
      when "80453094" then @@state["p1_y"] = hex_to_float(value)
      when "80453F20" then @@state["p2_x"] = hex_to_float(value)
      when "80453F24" then @@state["p2_y"] = hex_to_float(value)
      when "804530E0" then @@state["p1_percent"] = value[0..-5].to_i(16)
      when "80453F70" then @@state["p2_percent"] = value[0..-5].to_i(16)
      when "80453FC0 23A0" then @@state["p2_hitstun"] = hex_to_float(value)
      when "80453FC0 19BC" then @@state["p2_hitlag"] = hex_to_float(value)
      when "80453FC0 140" then @@state["p2_in_air"] = value
      when "80453FC0 12C" then @@state["p2_y_velocity"] = hex_to_float(value)
      else throw "Could not find address (#{address}) in game state"
    end
  end

  def hex_to_float(hex)
    [hex.to_i(16)].pack('L').unpack('F')[0]
  end
end

ai = Memreader.new
ai.monitor
