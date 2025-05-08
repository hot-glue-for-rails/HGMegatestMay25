require 'rails_helper'

describe 'interaction for PeopleController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

  # HOTGLUE-SAVESTART
  # HOTGLUE-END
  


  let!(:person1) {
    person = create(:person , 
                          name: FFaker::Movie.title )

    person.save!
    person
  }
  
  describe "index" do
    it "should show me the list" do
      visit people_path
      expect(page).to have_content(person1.name)
      expect(page).to have_content(person1.characteristics)
    end
  end

  describe "new & create" do
    it "should create a new Person" do
      visit people_path
      click_link "New Person"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Person")]')
      new_name = FFaker::Movie.title 
      find("[name='person[name]']").fill_in(with: new_name)

      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)
      expect(page).to have_content(new_characteristics)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit people_path
      find("a.edit-person-button[href='/people/#{person1.id}/edit']").click

      expect(page).to have_content("Editing #{person1.name.squish || "(no name)"}")
      new_name = FFaker::Movie.title 
      find("[name='person[name]']").fill_in(with: new_name)

      click_button "Save"
      within("turbo-frame#__#{dom_id(person1)} ") do
        expect(page).to have_content(new_name)
       expect(page).to have_content(new_characteristics)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit people_path
      accept_alert do
        find("form[action='/people/#{person1.id}'] > input.delete-person-button").click
      end
      expect(page).to_not have_content(person1.name)
      expect(Person.where(id: person1.id).count).to eq(0)
    end
  end
end

