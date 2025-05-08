require 'rails_helper'

describe 'interaction for CharacteristicsController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

    # HOTGLUE-SAVESTART
  # HOTGLUE-END
  

  let!(:characteristic1) {
    characteristic = create(:characteristic , 
                          name: FFaker::Movie.title )

    characteristic.save!
    characteristic
  }
  
  describe "index" do
    it "should show me the list" do
      visit characteristics_path
      expect(page).to have_content(characteristic1.name)
    end
  end

  describe "new & create" do
    it "should create a new Characteristic" do
      visit characteristics_path
      click_link "New Characteristic"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Characteristic")]')
      new_name = FFaker::Movie.title 
      find("[name='characteristic[name]']").fill_in(with: new_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit characteristics_path
      find("a.edit-characteristic-button[href='/characteristics/#{characteristic1.id}/edit']").click

      expect(page).to have_content("Editing #{characteristic1.name.squish || "(no name)"}")
      new_name = FFaker::Movie.title 
      find("[name='characteristic[name]']").fill_in(with: new_name)
      click_button "Save"
      within("turbo-frame#__#{dom_id(characteristic1)} ") do
        expect(page).to have_content(new_name)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit characteristics_path
      accept_alert do
        find("form[action='/characteristics/#{characteristic1.id}'] > input.delete-characteristic-button").click
      end
      expect(page).to_not have_content(characteristic1.name)
      expect(Characteristic.where(id: characteristic1.id).count).to eq(0)
    end
  end
end

