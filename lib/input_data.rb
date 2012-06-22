require 'CSV'
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

