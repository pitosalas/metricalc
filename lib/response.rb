class Response
  attr_reader :time
  def initialize resp_array
    @time = DateTime.parse(resp_array[0])
    @data = resp_array
  end

  def day
    @time.mday
  end
end
