require "./lib/survey_data"
require "./lib/input_data"
require "./lib/response"
require "./lib/round"
require 'pp'

if __FILE__ == $0
  surv = SurveyData.new
  inp = InputData.new 
  inp.read "/mydev/metricalc/data/weekly4file.csv", surv
  surv.process
  puts "File read in."
  puts "found #{surv.n_responses} responses."
  puts "found #{surv.n_rounds} of survey."

  puts "Found #{surv.n_questions} questions"
  surv.n_questions.times do
  	|x| puts "#{surv.question(x-1).index}. #{surv.question(x-1).text}"
  end
end