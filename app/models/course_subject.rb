class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  enum status: {started: 0, finished: 1}

  delegate :name, to: :task, prefix: true, allow_nil: true
end
