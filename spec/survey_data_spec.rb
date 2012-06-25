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
        [["6/4/2012 12:27:46", 1, 2],
         ["6/4/2012 12:27:46", 1, 2],
         ["6/10/2012 12:27:46", 1, 2],
         ["6/10/2012 12:27:46", 1, 2]])
         s.process
         s }
    it { subject.n_responses.should be == 4}
    it { subject.n_rounds.should be == 2 }
  end

  describe "small data with tricky rounds set" do
    subject { s = SurveyData.new(["Date", "Q1", "Q2"],
        [["6/4/2012 12:27:46", 1, 2],
         ["6/4/2012 12:27:46", 1, 2],
         ["6/10/2012 12:27:46", 1, 2],
         ["6/11/2012 12:27:46", 1, 2],
         ["6/12/2012 12:27:46", 1, 2]] )
        s.process
        s }
    it { subject.n_responses.should be == 5}
    it { subject.n_rounds.should be == 2 }
  end

  describe "use third week of data" do
    subject { surv = SurveyData.new
              inp = InputData.new 
              inp.read "/mydev/metriccalc/data/weeklyfile.csv", surv
              surv.process
              surv }
    it { subject.n_responses.should be == 33 }
    it { subject.n_rounds.should be == 3 }
    it { subject.n_responses_for_round(0).should be == 11 }
    it { subject.n_responses_for_round(1).should be == 11 }
    it { subject.n_responses_for_round(2).should be == 11 }

  end

end
