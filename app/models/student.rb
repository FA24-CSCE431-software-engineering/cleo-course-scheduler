# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :uin

  enum :enrol_semester, %i[fall spring], prefix: :enrol
  enum :grad_semester, %i[fall spring], prefix: :grad

  # Validations
  validates :uin, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 9 }
  validates :first_name, :last_name, :email, presence: true, length: { maximum: 255 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :enrol_year, :grad_year, presence: true, numericality: { only_integer: true }
  validates :enrol_semester, :grad_semester, presence: true

  # Student courses association
  # has_and_belongs_to_many :courses
  has_many :student_courses, dependent: :destroy
  has_many :courses, through: :student_courses

  belongs_to :major
end
