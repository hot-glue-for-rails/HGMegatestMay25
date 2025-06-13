# == Schema Information
#
# Table name: characteristics
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Characteristic < ApplicationRecord

  def label
    name

  end
end
