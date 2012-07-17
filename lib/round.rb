require_relative 'stats'
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

  def stats_for_question question_col, data
    total = 0
    minimum = 10
    maximum = 0
    count = 0
    ge3 = 0
    ge4 = 0
    (@start..@fin).each do 
      |response_row| 
      val = data.cell(question_col, response_row)
      unless val.nil?
        val = Response.string2choice val
        total += val
        count += 1
        minimum = val if val < minimum
        maximum = val if val > maximum
        if val >= 3
          ge3 += 1 
        end
        if val >= 4
          ge4 += 1
        end
      end
    end
    res = Stats.new
    if count == 0
      res.is_valid = false
    else
      res.is_valid = true
      res.total = total
      res.maximum = maximum
      res.minimum = minimum
      res.count = count
      res.ge3 = ge3
      res.ge4 = ge4
    end
    res
  end
end
