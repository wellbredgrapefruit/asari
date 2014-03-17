require_relative '../spec_helper'

describe "Asari" do
  before :each do
    @asari = Asari.new
  end

  describe "configuration" do
    it "defaults to the first CloudSearch API version." do
      expect(@asari.api_version).to eq "2011-02-01"
    end

    it "allows you to set a specific API version." do
      @asari.api_version = "2015-10-21" # WE'VE GOT TO GO BACK
      expect(@asari.api_version).to eq "2015-10-21"
    end

    it "allows you to set a specific aws region." do
      @asari.aws_region = "us-west-1"
      expect(@asari.aws_region).to eq("us-west-1")
    end

    it "raises an exeception if no search domain is provided." do
      expect { @asari.search_domain }.to raise_error Asari::MissingSearchDomainException
    end

    it "allows you to set a search domain." do
      @asari.search_domain = "theroyaldomainofawesome"
      expect(@asari.search_domain).to eq "theroyaldomainofawesome"
    end
  end

  describe "convert_date_or_time" do
    subject { @asari.send('convert_date_or_time', field) }

    context "Date, Time, DateTime and its subclasses" do
      [Time, Date, DateTime, ActiveSupport::TimeWithZone].each do |klass|
        let(:field) { klass.new(0,0) }

        its(:class) { should == Fixnum }
      end
    end

    context "Other random Classes" do
      ["string", 5, 1.0, :test].each do |obj|
        let(:field) { obj }

        its(:class) { should == field.class }
      end
    end
  end

end
