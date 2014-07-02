# encoding: utf-8
include ActionView::Helpers::SanitizeHelper
require 'facets/enumerable'
require 'textacular/searchable'

class Article < ActiveRecord::Base
  include Markdownifier

  extend FriendlyId
  extend Searchable(:title, :content_main, :title_es, :content_main_es, :title_cn, :content_main_cn)

  friendly_id :title, use: [:slugged, :history]

  belongs_to :category

  validates_presence_of :title, :content_main, :category

  scope :by_access_count, -> { order('access_count DESC') }
  scope :with_category, lambda { |category| where('categories.name = ?', category).joins(:category) }
  scope :published, -> { where(status: "Published") }

  def published?
    status == "Published"
  end

  def indexable?
    status == "Published"
  end
end
