class Subject < ApplicationRecord
  has_many :course_subjects
  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :tasks, allow_destroy: true
end
