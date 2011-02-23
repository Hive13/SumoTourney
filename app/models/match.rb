class Match < ActiveRecord::Base

  def validate
	errors.add_to_base "You must specify different robots to battle!" if first_bot_id == second_bot_id
  end

  def bot1_final_score
	final = first_bot_round1_score + first_bot_round2_score + first_bot_round3_score
	return final
  end

  def bot2_final_score
	final = second_bot_round1_score + second_bot_round2_score + second_bot_round3_score
	return final
  end
end
