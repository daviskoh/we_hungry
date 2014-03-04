module LoginSpecHelper
  def user_login
    visit '/session/new'

    within 'form' do 
      fill_in :email, with: "bob@bob.com"
      fill_in :password, with: "bob"
    end

    click_button 'Log In'
  end
end