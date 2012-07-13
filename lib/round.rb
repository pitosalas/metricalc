require 'ostruct'
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
    greater_or_equal_to3 = 0
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
          greater_or_equal_to3 += 1 
        end
      end
    end
    res = OpenStruct.new
    res.average = count == 0 ? "null" : sprintf("%.2f", ((1.0 * total) / count))
    res.maximum = maximum == 0 ? "" : maximum
    res.minimum = minimum == 10 ? "" : minimum
    res.count = count
    res.ge3 = greater_or_equal_to3
    res.ge3percent = count == 0 ? "null" : 
                    sprintf("%.2f\%", (greater_or_equal_to3*100.0 / count))
    res.rcolor = 256
    res.gcolor = count != 0 ? (128 + (128 * greater_or_equal_to3 / count)) : 256
    res.bcolor = 256

    res
  end
end

