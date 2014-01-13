require 'spec_helper'

describe 'food recommendation generator', js: true do 
  before :each do 
    user_login
  end

  it 'recommends food' do 
    click_link 'Generate Food'


  end
end