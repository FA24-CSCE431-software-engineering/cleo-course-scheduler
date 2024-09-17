class Student < ApplicationRecord
    self.primary_key = :uin

    enum :enrol_semester, [ :fall, :spring], prefix: :enrol
    enum :grad_semester, [ :fall, :spring], prefix: :grad

    # student courses association
    has_and_belongs_to_many :courses

    # validates :uin, presence: true, uniqueness: true
    # validates :first_name, :last_name, :email, presence: true, length: { maximum: 255 }
    # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    # validates :enrol_year, :grad_year, presence: true, numericality: { only_integer: true }
    # validates :enrol_semester, :grad_semester, presence: true
end