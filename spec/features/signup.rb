require 'spec_helper'

describe 'user signup', js: true do 
  before :each do 
    visit '/users/new'

    within 'form' do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: 'bob'
      fill_in 'Password confirmation', with: 'bob'

      click_button 'Sign Up'
    end
  end

  after :each do 
    User.destroy_all
  end

  it 'allows a user to create an account' do
    expect(User.last.email).to eq('bob@bob.com')
  end
end