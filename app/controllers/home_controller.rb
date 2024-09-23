class HomeController < ApplicationController
  def index
    Rails.application.eager_load! # because rails wont load unless they have been referenced at least once this forces them to be loaded
    # we could find a way to exclude these in a less hard-coded way
    excluded_models = [
      'StudentLogin', 'Track',
      'Prerequisite',
      'Major',
      'Emphasis',
      'DegreeRequirement',
      'Course',
      'CoreCategories',
      'ActionText::Record',
      'ActiveStorage::Record',
      'ActionMailbox::Record',
      'HABTM_Courses',
      'HABTM_Majors',
      'HABTM_Students',
      'ApplicationRecord',
      'ActionText::RichText',
      'ActionText::EncryptedRichText',
      'ActiveStorage::VariantRecord',
      'ActiveStorage::Attachment',
      'ActiveStorage::Blob',
      'ActionMailbox::InboundEmail'
    ]
    @models = ActiveRecord::Base.descendants.map(&:name) - excluded_models
  end
end

# this fetches the models and will make a list of all the existing tables/entities in our database
