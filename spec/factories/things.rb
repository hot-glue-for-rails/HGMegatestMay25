# == Schema Information
#
# Table name: things
#
#  id         :bigint           not null, primary key
#  person_id  :integer
#  bbb        :boolean
#  ccc        :date
#  ddd        :datetime
#  eee        :enum
#  fff        :float
#  iii        :integer
#  sss        :string
#  ttt        :text
#  mmm        :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :thing do
    person_id { 1 }
    bbb { false }
    ccc { "2025-05-08" }
    ddd { "2025-05-08 19:31:48" }
    eee { "" }
    fff { 1.5 }
    iii { 1 }
    sss { "MyString" }
    ttt { "MyText" }
    mmm { "2025-05-08 19:31:48" }
  end
end
