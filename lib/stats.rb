class Stats
  attr_accessor :total, :count, 
                :minimum, :maximum, :ge2, :ge3, :ge4, :data

  def initialize
    @data = []
    @total = 0
    @count = 0
    @total = 0
    @minimum = 10
    @maximum = 0
    @ge2 = 0 
    @ge3 = 0
    @ge4 = 0
  end

  def ge_3_percent_string
    "%.2f%" % (ge3*100.0 / count)
  end

  def ge_4_percent_string
    "%.2f%" % (ge4*100.0 / count)
  end

  def average_string
    "%.1f" % average
  end

  def average
    (1.0 * total) / count
  end

  def is_valid
    @count != 0
  end

  def pie_string
    if (is_valid)
      "#{ge4}, #{ge3-ge4}, #{count-ge3}"
    else
      "0, 0, 11"
    end
  end

  def brief_summary
    if (is_valid)
      "#{count}, #{ge3}, #{ge4}"
    else
      "no reports"
    end
  end
end
