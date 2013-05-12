require 'spec_helper'

describe MyActiveRecord::Database do
  context "loading from db" do
    it "loads schema" do
      User.methods.should include(:age)
    end

    it "loads data" do
      User.find(1).full_name.should == "Pedro Rodriguez Ledesma"
    end
  end
end