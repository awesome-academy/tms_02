class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  enum status: {in_progress: 0, finished: 1}
end
