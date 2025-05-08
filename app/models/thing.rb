class Thing < ApplicationRecord
  enum eee: {  'one': 'one',
                    'two': 'two',
                    'one': 'one',
                    'one': 'one',}


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

  has_many :things, dependent: :destroy




  def to_label
    "#{sss} #{bbb} #{ccc} #{ddd} #{eee} #{fff} #{iii} #{sss} #{ttt} #{mmm}"
  end
end
