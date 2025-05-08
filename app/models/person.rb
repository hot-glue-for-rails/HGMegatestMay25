class Person < ApplicationRecord
  has_many :people_characteristics, dependent: :destroy



  has_many :characteristics, through: :people_characteristics

end
