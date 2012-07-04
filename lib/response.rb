class Response
  def self.resp_choices
    [ [0, "Not a clue what it is"],
      [1, "Sounds familiar to me"],
      [2, "I feel I understand it"],
      [3, "I am able to use and apply it"],
      [4, "I know it in depth"]
    ]
  end

  def self.resp_choices_n
    self.resp_choices.size
  end

  def self.choice2string val
    self.resp_choices.find { |x| x[0] == val }[1]
  end

  def self.string2choice str
    self.resp_choices.find { |x| x[1] == str }[0]
  end

  attr_reader :time
  def initialize resp_array
    @time = DateTime.parse(resp_array[0])
    @data = resp_array
  end

  def value(question)
    @data[question]
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
