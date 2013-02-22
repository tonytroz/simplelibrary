require 'spec_helper'

describe User do
  before :each do
    @user = User.new("username", "password", "lendlimit")
  end

  describe "#new" do
    it "initializes with seven parameters and returns a User" do
      @user.should be_an_instance_of User
    end
  end

  describe "#username" do
    it "returns correct username" do
      @user.username.should == "username"
    end
  end
  describe "#password" do
    it "returns correct password" do
      @user.password.should == "password"
    end
  end
  describe "#lendlimit" do
    it "returns correct lendlimit" do
      @user.lendlimit.should == "lendlimit"
    end
  end
  describe "#books" do
    it "returns empty books array" do
      @user.books.should == []
    end
  end

  describe "#found_by_username" do
    it "returns user when username exists"
      User.find_by_username("username").should be_an_instance_of User
    end

    it "returns nil when username doesn't exist"
      User.find_by_username("xxxxx").should be_nil
    end
  end
end
