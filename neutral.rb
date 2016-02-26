module Neutral
  def evaluate_neutral(state)
    @state = state
    approach(state)
  end

  def approach(state)
    puts "P1 X #{state["p1_x"]}"
    puts "P2 X #{state["p2_x"]}"
    if state["p2_x"].to_f > state["p1_x"].to_f
      main_stick(0, 0.5)
    elsif state["p2_x"].to_f < state["p1_x"].to_f
      main_stick(1, 0.5)
    end
  end
end
