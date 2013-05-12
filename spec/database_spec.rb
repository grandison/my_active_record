require 'spec_helper'

describe MyActiveRecord::Database do
  context "loading from db" do
    it "loads schema from files" do
      User.methods.should include(:age)
    end
  end
end