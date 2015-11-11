class Enrollment < ActiveRecord::Base
  # Belongs_to automatically looks for passed value_id,
  # that's why you need it for user here
  belongs_to :course,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: "Course"

  belongs_to :user,
    primary_key: :id,
    foreign_key: :student_id,
    class_name: "User"
end
