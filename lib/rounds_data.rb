class RoundsData
  attr_accessor :start, :fin
  def initialize start_pos
    @start = start_pos
    @fin = nil
  end

  def n_resp
    @fin - @start
  end
end

