class Teacher < ActiveRecord::Base
  # implement your Teacher model here
  has_many: students
  validates :email, uniqueness: true
end
