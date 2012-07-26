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

# Program: id, name, 
# Round: id, program_id, index
# Item: id, text
# Questionaire: id, program_id, round_id
# Value: id, round_id, program_id, question_id, questionnaire_id, item_id

prog = Program.create(name: "JBS")
surv.n_questions.times do
  |x| prog.items.create(text: surv.question(x-1).text, index: surv.question(x-1).index)
end

surv.n_rounds.times do
  |x| prog.rounds.create(number: x)
end

v = values.create(value: val)
v.round = round
v.questionaire = questionaire
v.item = item

surv.rounds.each_with_index do 
  |round, ind| 
  round = prog.round.new(index: ind)
  round.program = prog


  




}









