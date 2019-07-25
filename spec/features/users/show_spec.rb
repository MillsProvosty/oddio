require 'rails_helper'

feature 'user show page' do
  describe 'as a visitor' do
    before(:each) do
      @user = create(:user)
      create_list(:recording, 2, user: @user)
    end

    it 'shows all recordings for one content creator' do
      VCR.use_cassette('visitor_sees_recordings_for_creator', record: :new_episodes) do
        visit user_path(@user)
        expect(page).to have_content(@user.display_name)
        expect(page.all('.recording-list').count).to eq(2)

        within(first('.recording-list')) do
          recording = @user.recordings.first
          expect(page).to have_content(recording.title)
          expect(page).to have_link(recording.landmark.name, href: landmark_path(recording.landmark))
          expect(page.all('audio').count).to eq(1)
        end
      end
    end

    it 'shows a message if there are no recordings' do
      VCR.use_cassette('visitor_sees_message_for_no_recordings', record: :new_episodes) do
        user = create(:user)
        visit user_path(user)

        expect(page).to have_content('Recordings')
        expect(page).to have_content('No recordings uploaded yet')
      end
    end
  end
end
