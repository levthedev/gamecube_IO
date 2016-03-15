module Neutral
  def evaluate_neutral(state)
    @state = state
    in_hitstun? && in_air? ? di : main_stick(0.5, 0.5)
    tech_situation? ? tech : release("L")
  end

  def in_hitstun?
    (@state["p2_hitstun"].to_f ) > 0.0
  end

  def in_air?
    # puts "#{@state['p2_in_air']}, #{@state["p2_y"].to_f}"
    (@state["p2_in_air"].to_s.chars[-1] == "0")
  end

  def tech_situation?
    in_air? && (@state["p2_y"].to_f < 15) && (@state["p2_y_velocity"].to_f < 0)
  end

  def tumble?
    # consult ssbm data sheet
  end

  def di
    main_stick(rand(-1.0..1.0), 0.5)
  end

  def tech
    press("L")
  end
end
