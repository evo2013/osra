require 'rails_helper'

describe "hq/users/index.html.erb", type: :view do

  it 'should have a New User link' do
    assign(:users, [])
    render
    expect(rendered).to have_link('New User', new_hq_user_path)
  end

  describe 'should display users correctly' do

    context 'no users' do
      it 'displays just the header row' do
        @users = []
        render
        expect(rendered).to have_selector('table tr', count: 1)
      end
    end

    context '1 user' do
      it 'displays a single user' do
        @users = [ double('User', user_name: 'Frederick Bloggs', 
          email: 'fred.bloggs@example.com', active_sponsors: (1..5).to_a)]
        render
        expect(rendered).to have_selector('table tr', count: 2)
        expect(rendered).to have_link('Frederick Bloggs', href: hq_user_path(@users[0]))
        expect(rendered).to match 'fred.bloggs@example.com'
        expect(rendered).to match '5'
      end
    end

    context '>1 user' do
      it 'displays multiple users' do
        @users = [ double('User', user_name: 'Frederick Bloggs', 
          email: 'fred.bloggs@example.com', active_sponsors: (1..5).to_a), 
                   double('User', user_name: 'Joseph Soap', 
          email: 'joe.soap@example.com', active_sponsors: (1..7).to_a) ]
        render
        expect(rendered).to have_selector('table tr', count: 3)
        expect(rendered).to have_link('Frederick Bloggs', href: hq_user_path(@users[0]))
        expect(rendered).to match 'fred.bloggs@example.com'
        expect(rendered).to match '5'
        expect(rendered).to have_link('Joseph Soap', href: hq_user_path(@users[1]))
        expect(rendered).to match 'joe.soap@example.com'
        expect(rendered).to match '7'
      end
    end

  end

end
