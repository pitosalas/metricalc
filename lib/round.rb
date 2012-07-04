class Round
  attr_accessor :start, :fin
  def initialize start_pos
    @start = start_pos
    @fin = nil
  end

  def n_resp
    (@fin - @start) + 1
  end

  def average_for_question(question_col, data)
  	total = 0
  	count = 0
  	(@start..@fin).each do 
  		|response_row| 
  		val = data.cell(question_col, response_row)
  		unless val.nil?
  			val = Response.string2choice val
  			total += val
  			count += 1
  		end
  	end
  	count == 0 ? "null" : sprintf("%.2f", ((1.0 * total) / count))
  end
end

