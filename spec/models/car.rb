class Car < MyActiveRecord::Base
  belongs_to :user
  has_many :details
end