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
    res = Stats.new
    (@start..@fin).each do |response_row| 
      val = data.cell(question_col, response_row)
      if !val.nil?
        val = Response.string2choice val
      end
      res.data << val
      unless val.nil?
        res.total += val
        res.count += 1
        res.minimum = val if val < res.minimum
        res.maximum = val if val > res.maximum
        if val >= 2
          res.ge2 += 1
        end
        if val >= 3
          res.ge3 += 1 
        end
        if val >= 4
          res.ge4 += 1
        end
      end
    end
    res
  end
end
