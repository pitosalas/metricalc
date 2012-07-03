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
    #puts "Processing..."
    @responses.sort { |a, b| a.calendar_week <=> b.calendar_week }
    determine_rounds
  end

  # analyze input data and detect voting rounds
  def determine_rounds
    @rounds = []
    the_round = 0
    @rounds[the_round] = RoundsData.new(0)
    @responses.each_index do |ind|
      if !(@responses[ind+1].nil? || @responses[ind].same_round?(@responses[ind+1]))
        @rounds[the_round].fin = ind
        #puts "round boundary: #{the_round}, #{@rounds[the_round].inspect}, #{ind}"
        the_round += 1
        @rounds[the_round] = RoundsData.new(ind+1)
      end
    end
    @rounds[the_round].fin = @responses.length-1
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

  def n_students
    n_responses / n_rounds
  end

  def n_weeks
    n_rounds
  end

  def response_choices
    Response.response_choices
  end

end
