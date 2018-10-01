class Food < ApplicationRecord
  validates_presence_of :calories, :name
end
