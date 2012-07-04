require 'CSV'
class InputData

  def read(file, surv)
    rowcount = 0
    CSV.foreach(file) do |row|
      if rowcount == 0
        add_questions(surv, row)
      else
        surv.add_response(row)
      end
      rowcount += 1
    end
  end

  def add_questions(surv, row)
    (9..29).each { |i| surv.add_question(i, row[i].scan(/\[(.+)\]/).last.first)}
    (31..37).each { |i| surv.add_question(i, row[i].scan(/\[(.+)\]/).last.first)}
    (39..43).each { |i| surv.add_question(i, row[i].scan(/\[(.+)\]/).last.first)}
  end
end

