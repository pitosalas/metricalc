class Stats
  attr_accessor :is_valid, :total, :count, :minimum, :maximum, :ge3, :ge4

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

  def pie_string
    "#{ge4}, #{ge3-ge4}, #{count-ge3}"
  end

  def brief_summary
    "#{count}, #{ge3}, #{ge4}"
  end
end
