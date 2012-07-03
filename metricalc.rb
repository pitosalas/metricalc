require "./lib/survey_data"
require "./lib/input_data"
require "./lib/response"
require "./lib/rounds_data"
require 'pp'

if __FILE__ == $0
  surv = SurveyData.new
  inp = InputData.new 
  inp.read "/mydev/metriccalc/data/weekly4file.csv", surv
  surv.process
  puts "File read in."
  puts "found #{surv.n_responses} responses."
  puts "found #{surv.n_rounds} of survey."

  Resp
  pp surv.rounds
end