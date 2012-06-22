require 'american_date'
require_relative 'rounds_data'

class SurveyData
  attr_accessor :rounds

  def initialize ques=[], resp=[]
    @rounds = []
    @responses = []
    @questions = ques
    resp.each { |r| add_response r }
  end

  def set_questions q_array
    startColForQuestions = 8
    @questions = nil
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

  def n_responses_for_round n
    @rounds[n].n_resp
  end

  # return how many rounds of surveying happened
  def n_rounds
    process
    @rounds.size
  end

  def n_responses
    @responses.size
  end

end
