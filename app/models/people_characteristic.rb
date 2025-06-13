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
class PeopleCharacteristic < ApplicationRecord
  belongs_to :person
  belongs_to :characteristic
end
