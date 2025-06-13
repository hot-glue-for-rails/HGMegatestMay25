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
require 'rails_helper'

RSpec.describe Thing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
