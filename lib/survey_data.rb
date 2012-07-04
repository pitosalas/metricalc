require 'american_date'
require_relative 'round'
require_relative 'question'

class SurveyData
  attr_accessor :rounds

  def initialize(ques=[], resp=[])
    @rounds = []
    @responses = []
    @questions = []
    resp.each { |r| add_response r }
    ques.each_with_index { |q, i| add_question(i, q)}
  end

  def add_response(resp_array)
    @responses << Response.new(resp_array)
  end

  def add_question(index, qstring)
    @questions << Question.new(index, qstring)
  end

  def process
    @responses.sort { |a, b| a.calendar_week <=> b.calendar_week }
    determine_rounds
  end

  # analyze input data and detect voting rounds
  def determine_rounds
    @rounds = []
    the_round = 0
    @rounds[the_round] = Round.new(0)
    @responses.each_index do |ind|
      if !(@responses[ind+1].nil? || @responses[ind].same_round?(@responses[ind+1]))
        @rounds[the_round].fin = ind
        the_round += 1
        @rounds[the_round] = Round.new(ind+1)
      end
    end
    @rounds[the_round].fin = @responses.length-1
  end

  def cell(question_col, response_row)
    @responses[response_row].value(question_col)
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
    (1.0 * n_responses) / n_rounds
  end

  def n_weeks
    n_rounds
  end

  def response_choices
    Response.response_choices
  end

  def n_questions
    @questions.size
  end

  def question i
    @questions[i]
  end

  def question_response_avg_vector(question)
  #  [1,1,2,2,3,3,4,5,5]
    raise "invalid question number" if question > n_questions
    @rounds.map { |r| r.average_for_question(@questions[question].index, self) }
  end

end
