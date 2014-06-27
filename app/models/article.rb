# encoding: utf-8
include ActionView::Helpers::SanitizeHelper
require 'facets/enumerable'

class Article < ActiveRecord::Base
  include TankerArticleDefaults
  include Tanker
  include Markdownifier

  extend FriendlyId

  friendly_id :title, use: [:slugged, :history]

  belongs_to :category

  validates_presence_of :title, :content_main, :category

  scope :by_access_count, -> { order('access_count DESC') }
  scope :with_category, lambda { |category| where('categories.name = ?', category).joins(:category) }
  scope :published, -> { where(status: "Published") }

  after_save :update_tank_indexes, unless: Proc.new { Rails.env.test? || Rails.env.development? }
  after_destroy :delete_tank_indexes, unless: Proc.new { Rails.env.test? || Rails.env.development? }

  handle_asynchronously :update_tank_indexes
  handle_asynchronously :delete_tank_indexes

  STOP_WORDS = ['a','able','about','across','after','all','almost','also','am','among','an','and','any','are','as','at','be','because','been','but','by','can','cannot','could','dear','did','do','does','either','else','ever','every','for','from','get','got','had','has','have','he','her','hers','him','his','how','however','i','if','in','into','is','it','its','just','least','let','like','likely','may','me','might','most','must','my','neither','no','nor','not','of','off','often','on','only','or','other','our','own','rather','said','say','says','she','should','since','so','some','than','that','the','their','them','then','there','these','they','this','tis','to','too','twas','us','wants','was','we','were','what','when','where','which','while','who','whom','why','will','with','would','yet','you','your']

  def self.search( query )
    return Article.all if query.blank?
    self.search_tank query
  end

  def self.search_titles( query )
    return Article.all if query.blank?
    self.search_tank( '__type:Article', :conditions => {:title => query })
  end

  def published?
    status == "Published"
  end

  def self.remove_stop_words string
    eng_stop_list = Rails.cache.fetch('stop_words') do
      CSV.read( "#{Rails.root.to_s}/lib/assets/eng_stop.csv" )
    end
    string = (string.downcase.split - eng_stop_list.flatten).join " "
  end

  def indexable?
    status == "Published"
  end
end
