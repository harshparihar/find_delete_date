require 'find_delete_date'

describe FindDeleteDate do

  context "No plan" do
    it "should return nil as delete date" do
      resp = FindDeleteDate::Calculate.delete_date("", Date.parse("31-7-2021"))
      expect(resp).to eq(nil)
    end
  end

  context "Standard plan" do
    it "should return proper delete date of after 42 days" do
      date = Date.today-10
      resp = FindDeleteDate::Calculate.delete_date(:standard, date)
      expect(resp).to eq(date+42)
    end
  end

  context "Gold plan" do
    it "should return delete date of after 42 days" do
      date = Date.today-10
      resp = FindDeleteDate::Calculate.delete_date(:gold, date)
      expect(resp).to eq(date+42)
    end

    it "should return the delete date of 12 months for month end dates" do
      date = Date.parse("31-07-2021")
      resp = FindDeleteDate::Calculate.delete_date(:gold, date)
      expect(resp).to eq(date+365)

      date = Date.parse("30-06-2021")
      resp = FindDeleteDate::Calculate.delete_date(:gold, date)
      expect(resp).to eq(date+365)
    end
  end


  context "Check platinum plan" do
    it "should return delete date of after 42 days" do
      date = Date.today-12
      resp = FindDeleteDate::Calculate.delete_date(:platinum, date)
      expect(resp).to eq(date+42)
    end

    it "should return the delete date of 12 months for month end dates" do
      date = Date.parse("31-05-2021")
      resp = FindDeleteDate::Calculate.delete_date(:platinum, date)
      expect(resp).to eq(date+365)
    end

    it "should return the delete date of 7 years for year end dates" do
      date = Date.parse("31-12-2019")
      resp = FindDeleteDate::Calculate.delete_date(:platinum, date)
      expect(resp).to eq(date + (7*365))
    end

  end
end