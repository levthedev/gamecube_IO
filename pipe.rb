module Pipe
  include Math

  def path
    "/Users/levkravinsky/Library/Application\ Support/Dolphin/Pipes/pipe"
  end

  def press(button)
    `echo "PRESS #{button}" >> "#{path}"`
  end

  def release(button)
    `echo "RELEASE #{button}" >> "#{path}"`
  end

  def tap(button, frames = 1.0)
    press(button)
    sleep(frames / 60.0)
    release(button)
  end

  def main_stick(x, y)
    `echo "SET MAIN #{x}, #{y}" >> "#{path}"`
  end

  def c_stick(x, y)
    `echo "SET C #{x}, #{y}" >> "#{path}"`
  end
end
