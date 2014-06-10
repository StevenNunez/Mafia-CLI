class Student < ActiveRecord::Base
  validate :name, presence: true
end
