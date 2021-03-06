require_relative '../lib/survey_data.rb'
require_relative '../lib/input_data.rb'
require_relative '../lib/response.rb'

describe "test input data" do
  let(:sdr) { SurveyData.new([], []) }

  it "knows the length of the empty survey data" do
    sdr.n_responses.should be == 0
  end

  describe "test a small data set" do
    subject { s = SurveyData.new(["Date", "Q1", "Q2"],
        [["7/8/2012 12:27:46", 1, 2],
         ["7/7/2012 12:27:46", 1, 2],
         ["7/9/2012 12:27:46", 1, 2],
         ["7/10/2012 12:27:46", 1, 100]])
         s.process
         s }
    it { subject.n_responses.should be == 4}
    it { subject.n_rounds.should be == 2 }
    it { subject.rounds[0].start.should be == 0}
    it { subject.rounds[0].fin.should be == 1}
    it { subject.rounds[1].start.should be == 2}
    it { subject.rounds[1].fin.should be == 3}
    it { subject.rounds[2].should be_nil }
    it { subject.n_questions.should be == 3}
    it { subject.question(2).text.should be == "Q2" }
    it { subject. cell(1, 0).should be == 1 }
    it { subject. cell(2, 3).should be == 100 }
    it { subject.rounds[0].average_for_question(2, subject).should be == 2}
    it { subject.rounds[1].average_for_question(2, subject).should be == 51}


  end

  describe "small data with tricky rounds set" do
    subject { s = SurveyData.new(["Date", "Q1", "Q2"],
        [["7/1/2012 12:27:46", 1, 2],
         ["7/2/2012 12:27:46", 1, 2],
         ["7/6/2012 12:27:46", 1, 2],
         ["7/8/2012 12:27:46", 1, 2],
         ["7/9/2012 12:27:46", 1, 2]] )
        s.process
        s }
    it { subject.n_responses.should be == 5}
    it { subject.n_rounds.should be == 3 }
    it { subject.rounds[0].start.should be == 0}
    it { subject.rounds[0].fin.should be == 0}
    it { subject.rounds[1].start.should be == 1}
    it { subject.rounds[1].fin.should be == 3}
    it { subject.rounds[2].start.should be == 4}
    it { subject.rounds[2].fin.should be == 4}
    it { subject.rounds[3].should be_nil }
  end

  describe "use third week of data" do
    subject { surv = SurveyData.new
              inp = InputData.new 
              inp.read "/mydev/metricalc/data/weekly4file.csv", surv
              surv.process
              surv }
    it { subject.n_responses.should be == 44 }
    it { subject.n_rounds.should be == 4 }
    it { subject.n_responses_for_round(0).should be == 11 }
    it { subject.n_responses_for_round(1).should be == 11 }
    it { subject.n_responses_for_round(2).should be == 11 }
    it { subject.question(0).text.should be == "Ruby Programming"}
    it { subject.question(0).text.class.should be == String }
    it { subject.n_questions.should be == 3}
    it { subject.question(2).text.should be == "Unit tests (Rspec)" }
    it { subject. cell(9, 0).should be == "I am able to use and apply it" }
    it { subject. cell(10, 2).should be == "Sounds familiar to me"}
    it { subject.rounds[0].average_for_question(2, subject).should be == 2}
    it { subject.rounds[1].average_for_question(2, subject).should be == 51}


  end

  describe "monday to sunday is one week" do
    before(:all) do
      @monday = DateTime.parse("july 2 2012")
      @tuesday = DateTime.parse("july 3 2012")
      @saturday = DateTime.parse("july 7 2012")
      @sunday = DateTime.parse("july 8 2012")
      @following_monday = DateTime.parse("july 9 2012")
    end
    it "knows monday and tuesday are the same week" do
      @monday.cweek.should be_equal @tuesday.cweek
    end

    it "knows saturday and sunday are the same week" do
      @saturday.cweek.should be == @sunday.cweek
    end
    it "knows sunday and the next monday are different weeks" do
      @sunday.cweek.should be == @following_monday.cweek-1
    end 
  end
end
