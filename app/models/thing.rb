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
class Thing < ApplicationRecord

  def person_idable?
    !bbb
  end

  enum eee: {  'one': 'one',
                    'two': 'two',
                    'three': 'three',
                    'four': 'four',
                    'five': 'five',
                    'six': 'six',
                    'seven': 'seven',
                    'eight': 'eight',
                    'nine': 'nine',
                    'ten': 'ten',}


  belongs_to :person

  def self.eee_enum_labels
    {
      'one': '1',
      'two': '2',
      'three': '3',
      'four': '4',
      'five': '5',
      'six': '6',
      'seven': '7',
      'eight': '8',
      'nine': '9',
      'ten': '10'
    }
  end


  def to_label
    "#{sss} #{bbb} #{ccc} #{ddd} #{eee} #{fff} #{iii} #{sss} #{ttt} #{mmm}"
  end
end
