require 'rails_helper'

describe 'interaction for ThingsController' do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

  # HOTGLUE-SAVESTART
  # HOTGLUE-END
  
  let!(:person1) {create(:person)}









  let!(:thing1) {
    thing = create(:thing , 
                          person: person1, 
                          bbb: !!rand(2).floor, 
                          ccc: Date.current + rand(50).days, 
                          ddd: DateTime.current + 1.day, 
                          fff: rand(1)*10000, 
                          iii: rand(100), 
                          sss: FFaker::Movie.title, 
                          ttt:  FFaker::Lorem.paragraphs(10).join(), 
                          mmm: Time.current + rand(5000).seconds )

    thing.save!
    thing
  }
  
  let(:testing_timezone) {
    Rails.application.config.time_zone
  }
  describe "index" do
    it "should show me the list" do
      visit things_path
      
      expect(page).to have_content(thing1.bbb ? 'YES' : 'NO')
      expect(page).to have_content(thing1.ccc)
      expect(page).to have_content(thing1.ddd.in_time_zone(testing_timezone).strftime('%m/%d/%Y @ %l:%M %p %Z').gsub('  ', ' '))
      expect(page).to have_content(thing1.eee)
      expect(page).to have_content(thing1.fff)
      expect(page).to have_content(thing1.iii)
      expect(page).to have_content(thing1.sss)
      expect(page).to have_content(thing1.ttt)
      
    end
  end

  describe "new & create" do
    it "should create a new Thing" do
      visit things_path
      click_link "New Thing"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Thing")]')
      person_id_selector = find("[name='thing[person_id]']").click 
      person_id_selector.first('option', text: person1.name).select_option
      new_bbb = 1 
      find("[name='thing[bbb]'][value='#{new_bbb}']").choose
      new_ccc = Date.current + (rand(100).days) 
      find("[name='thing[ccc]']").fill_in(with: new_ccc)
      new_ddd = DateTime.current + 1.year 
      find("[name='thing[ddd]']").fill_in(with: new_ddd)
      list_of_eee_enum = Thing.defined_enums['eee'].keys 
      new_eee = list_of_eee_enum[rand(list_of_eee_enum.length)].to_s 
      find("select[name='thing[eee]']  option[value='#{new_eee}']").select_option
      new_fff = rand(10) 
      find("[name='thing[fff]']").fill_in(with: new_fff)
      new_iii = rand(10) 
      find("[name='thing[iii]']").fill_in(with: new_iii)
      new_sss = FFaker::Movie.title 
      find("[name='thing[sss]']").fill_in(with: new_sss)
      new_ttt = FFaker::Lorem.paragraphs(1).join() 
      find("[name='thing[ttt]']").fill_in(with: new_ttt)
      new_mmm = Time.current + 5.seconds 
      find("[name='thing[mmm]']").fill_in(with: new_mmm)
      click_button "Save"
      expect(page).to have_content("Successfully created")

       expect(page).to have_content(person1.name)
      expect(page).to have_content(thing1.bbb ? 'YES' : 'NO')
      expect(page).to have_content(new_ccc)
      expect(page).to have_content(new_ddd.in_time_zone(testing_timezone).strftime('%m/%d/%Y @ %l:%M %p %Z').gsub('  ', ' '))
      expect(page).to have_content(new_eee)
      expect(page).to have_content(new_fff)
      expect(page).to have_content(new_iii)
      expect(page).to have_content(new_sss)
      expect(page).to have_content(new_ttt)
      expect(page).to have_content(new_mmm.strftime('%l:%M %p').strip)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit things_path
      find("a.edit-thing-button[href='/things/#{thing1.id}/edit']").click

      expect(page).to have_content("Editing #{thing1.to_label.squish || "(no name)"}")
      person_id_selector = find("[name='thing[person_id]']").click 
      person_id_selector.first('option', text: person1.name).select_option
      new_bbb = 1 
      find("[name='thing[bbb]'][value='#{new_bbb}']").choose
      new_ccc = Date.current + (rand(100).days) 
      find("[name='thing[ccc]']").fill_in(with: new_ccc)
      new_ddd = DateTime.current + 1.year 
      find("[name='thing[ddd]']").fill_in(with: new_ddd)
      list_of_eee_enum = Thing.defined_enums['eee'].keys 
      new_eee = list_of_eee_enum[rand(list_of_eee_enum.length)].to_s 
      find("select[name='thing[eee]']  option[value='#{new_eee}']").select_option
      new_fff = rand(10) 
      find("[name='thing[fff]']").fill_in(with: new_fff)
      new_iii = rand(10) 
      find("[name='thing[iii]']").fill_in(with: new_iii)
      new_sss = FFaker::Movie.title 
      find("[name='thing[sss]']").fill_in(with: new_sss)
      new_ttt = FFaker::Lorem.paragraphs(1).join() 
      find("[name='thing[ttt]']").fill_in(with: new_ttt)
      new_mmm = Time.current + 5.seconds 
      find("[name='thing[mmm]']").fill_in(with: new_mmm)
      click_button "Save"
      within("turbo-frame#__#{dom_id(thing1)} ") do
         expect(page).to have_content(person1.name)
       expect(page).to have_content(thing1.bbb ? 'YES' : 'NO')
       expect(page).to have_content(new_ccc)
       expect(page).to have_content(new_ddd.in_time_zone(testing_timezone).strftime('%m/%d/%Y @ %l:%M %p %Z').gsub('  ', ' '))
       expect(page).to have_content(new_eee)
       expect(page).to have_content(new_fff)
       expect(page).to have_content(new_iii)
       expect(page).to have_content(new_sss)
       expect(page).to have_content(new_ttt)
       expect(page).to have_content(new_mmm.strftime('%l:%M %p').strip)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit things_path
      accept_alert do
        find("form[action='/things/#{thing1.id}'] > input.delete-thing-button").click
      end
      expect(page).to_not have_content(thing1.to_label)
      expect(Thing.where(id: thing1.id).count).to eq(0)
    end
  end
end

