require 'spec_helper'

describe "User pages" do

  #tells RSpec that page is the subject of the tests.
  #the call to should command(method) automatically uses the page variable supplied by capybara.
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
    #full_title is a test helper method defined in spec/support/utilities.rb
  end
end
