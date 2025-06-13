# == Schema Information
#
# Table name: characteristics
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :characteristic do
    name { "MyString" }
  end
end
