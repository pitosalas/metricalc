class Response
  attr_reader :time
  def initialize resp_array
    @time = DateTime.parse(resp_array[0])
    @data = resp_array
  end

  def day
    @time.mday
  end

  def calendar_week
    @time.cweek
  end

  def same_round? other
    self.calendar_week == other.calendar_week
  end
end
