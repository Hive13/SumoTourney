class Tournament < ActiveRecord::Base
  has_many :matches

  def total_matches
	total = matches.size
        next_round = total
	while(next_round > 1) do
		next_round = (next_round / 2).round
		total += next_round
	end
	return total
  end

  def total_rounds
        next_round = matches.size
	rounds = 1
	while(next_round > 1) do
		next_round = (next_round / 2).round
		rounds += 1
	end
	return rounds
  end
end
