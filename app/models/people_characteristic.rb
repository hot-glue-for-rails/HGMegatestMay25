class PeopleCharacteristic < ApplicationRecord
  belongs_to :person
  belongs_to :characteristic
end
