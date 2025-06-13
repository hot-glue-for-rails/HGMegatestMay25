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
FactoryBot.define do
  factory :people_characteristic do
    person_id { 1 }
    characteristic_id { 1 }
  end
end
