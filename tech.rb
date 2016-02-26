module Tech
  def short_hop
    tap("X")
  end

  def wavedash(direction)
    tap("X", 2.0)
    case direction
    when :down
      main_stick(0.5, 0)
    when :left
      main_stick(0, 0.3)
    when :right
      main_stick(1, 0.3)
    end
    tap("L")
    main_stick(0.5, 0.5)
  end

  def shine
    main_stick(0.5, 0)
    tap("B")
    main_stick(0.5, 0.5)
  end

  def doubleshine
    shine
    sleep(2.0/60)
    tap("X", 0.5)
    sleep(1.5/60)
    shine
    sleep(1.5/60)
    wavedash(:down)
    main_stick(0.5, 0.5)
  end

  def shffl(aerial)
  end
end
