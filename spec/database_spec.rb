require 'spec_helper'

describe MyActiveRecord::Database do
  context "loading from db" do
    it "loads schema" do
      User.new.methods.should include(:age)
    end

    it "finds data" do
      User.find(1).name.should == "Pedro Rodriguez Ledesma"
    end
  end

  context "saving to db" do
    it "creates new records" do
      User.create(:name => "Test User")
      User.last.name.should == "Test User"
    end

    it "generates id" do
      User.create(:name => "Test User")
      User.last.id.should == "3"
    end

    it "updates records" do
      user = User.find(1)
      user.name = "Updated name"
      user.save
      User.find(1).name.should == "Updated name"
    end
  end
end