require 'spec_helper'

describe MyActiveRecord::Base do
  let(:user) { User.find(1) }
  let(:user_without_car) { User.find(2) }

  context "associations" do
    context "#has_one" do
      it "loads association from db" do
        user.car.name.should == "Tata Motors Aria"
      end

      it "is empty by default" do
        user_without_car.car.should be_blank
      end
    end
  end
end