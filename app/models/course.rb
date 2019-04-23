class Course < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :supervisor_courses, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :subjects, through: :course_subjects

  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  enum status: {open: 0, start: 1, finished: 2}

  scope :newest, -> {order created_at: :DESC}
end
