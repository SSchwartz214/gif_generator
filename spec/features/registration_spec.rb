require 'rails_helper'

describe 'resgistration workflow' do
  it 'submits registration form successfully' do
    first_name = 'LeBron'

    visit root_path

    click_on 'Sign up to be a New User'

    expect(current_path).to eq(new_user_path)

    fill_in :user_first_name, with: first_name
    fill_in :user_last_name, with: 'James'
    fill_in :user_email, with: 'KingJames@gmail.com'
    fill_in :user_password, with: 'lakers'

    click_on 'Create User'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Welcome, #{first_name}!")
  end
  it 'submits registration form with duplicate username' do
    first_name = 'LeBron'
    User.create(first_name: "LeBron", last_name: "James", email: 'KingJames@gmail.com', password: 'lakers', role: 0)
    count = User.count

    visit root_path

    click_on 'Sign up to be a New User'

    expect(current_path).to eq(new_user_path)

    fill_in :user_first_name, with: first_name
    fill_in :user_last_name, with: 'James'
    fill_in :user_email, with: 'KingJames@gmail.com'
    fill_in :user_password, with: 'lakers'

    click_on 'Create User'

    expect(User.count).to eq(count)
    expect(current_path).to eq(users_path)
  end
end
