class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  enum status: {in_progress: 0, finished: 1}
end
