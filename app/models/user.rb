class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :user_courses, dependent: :destroy
  has_many :supervisor_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  enum role: {trainee: 0, supervisor: 1}

end
