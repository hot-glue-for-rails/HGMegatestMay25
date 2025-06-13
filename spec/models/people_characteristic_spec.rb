# == Schema Information
#
# Table name: people_characteristics
#
#  id                :bigint           not null, primary key
#  person_id         :integer
#  characteristic_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe PeopleCharacteristic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
