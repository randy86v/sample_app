require 'spec_helper'

describe "Static pages" do 

  #tells RSpec that page is the subject of the tests.
  #the call to should command(method) automatically uses the page variable supplied by capybara.
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: page_title) }
  end
  
  describe "Home page" do
    before { visit root_path }                          
    
    #let command(or method) creates local variable in Rspec 
    let(:heading) { 'Sample App' }
    let(:page_title) { full_title('') }
    #full_title is a test helper method defined in spec/support/utilities.rb
        
    it { should_not have_selector('title', text: " | Home") } 
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      
      it "should render user's feed" do
        user.feed.each do |item|
          page.should have_selector "li##{item.id}", text: item.content
        end
      end
    end  
  end
  
  describe "Help page" do
    before { visit help_path }
    
    let(:heading) {'Help'}
    let(:page_title) { full_title('Help') }
  end
  
  describe "About page" do
    before { visit about_path }
    
    let(:heading) { 'About Us' }
    let(:page_title) { full_title('About Us') }
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    let(:heading) { 'Contact' }
    let(:page_title) { full_title('Contact') }    
  end
  
  it "should have the right links to the layouts" do
    visit root_path
    click_link "About"
    should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now"
    should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    should have_selector 'a', text: /sample app/i
  end
end
