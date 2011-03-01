class Match < ActiveRecord::Base

  belongs_to :tournament

  def validate
	if first_bot_id == nil and first_bot_from_match == nil then
	   errors.add_to_base "You must specify either a first bot or first bot match"
	elsif second_bot_id == nil and second_bot_from_match == nil then
	   errors.add_to_base "You must specify either a second bot or second bot match"
        end

	errors.add_to_base "You must specify different robots to battle!" if first_bot_id == second_bot_id and not first_bot_id == nil
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
