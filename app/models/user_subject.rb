class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :user_course
  belongs_to :course_subject

  has_many :user_tasks, dependent: :destroy

  accepts_nested_attributes_for :user_tasks, allow_destroy: true

  enum status: {in_progress: 0, finished: 1}
end
