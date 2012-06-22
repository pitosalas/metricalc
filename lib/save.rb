
class InputData

  def read(file, surv)
    rowcount = 0
    CSV.foreach(file) do |row|
      if rowcount == 0 
        surv.set_questions(row)
      else
        surv.add_response(row)
      end
      rowcount += 1
    end
  end
end

class Response
  attr_reader :time
  def initialize resp_array
    @time = DateTime.parse(resp_array[0])
    @data = resp_array
  end

  def day
    @time.mday
  end
end

class RoundsData
  attr_accessor :start, :fin
  def initialize start_pos
    @start = start_pos
    @fin = nil
  end

  def n_resp
    @fin - @start
  end
end


class SurveyData
  attr_reader :rounds

  def initialize
    @questions = []
    @responses = []
    @rounds = []
  end

  def set_questions q_array
    startColForQuestions = 8
    @questions = 
  end

  def add_response(resp_array)
    @responses << Response.new(resp_array)
  end

  def process
    @responses.sort { |a, b| a.day <=> b.day }
    determine_rounds
  end

  # analyze input data and detect voting rounds
  def determine_rounds
    nround = 0
    @rounds[nround] = RoundsData.new(0)
    spos = 0
    sday = @responses[spos].day
    @responses.each_index do
      |ind|
      if @responses[ind].day > sday + 1
        @rounds[nround].fin = ind-1
        nround += 1
        @rounds[nround] = RoundsData.new(ind)
        spos = ind
        sday = @responses[ind].day
      end
    end
    @rounds[nround].fin = @responses.length
  end


  # return how many rounds of surveying happened
  def n_rounds
    @rounds.size
  end

  def n_responses
    @responses.size
  end
end
