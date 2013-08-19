require 'spec_helper'

describe "user logs in" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "successful login" do
    it "should go to some page and fill textbox" do
        browser.goto "/"
        browser.text.include?('Hello, Hospitium!').should == true
    end
  end
  
  describe "successful login" do
    it "should go to some page and fill textbox" do
        browser.goto user_session_path
        # browser.text_field(name: "user[login]").wait_until_present
        browser.text_field(name: "user[login]").set @user.username
        browser.text_field(name: "user[password]").set "password"
        browser.button(name: "commit").click
        browser.text.include?('Signed in successfully.').should == true
    end
  end
  
  # describe "#create_uuid" do
  #   let(:note) { FactoryGirl.create(:note) }
    
  #   it "generates a uuid on creation" do
  #     note.uuid.should_not be_nil
  #   end
  # end
end
