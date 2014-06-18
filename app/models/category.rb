class Category < ActiveRecord::Base
  extend FriendlyId
  has_many :articles

  before_validation :set_access_count_if_nil

  friendly_id :name, use: [:slugged, :history]
  scope :by_access_count, -> { order('access_count DESC') }

  private

  def hits
    access_count
  end

  def set_access_count_if_nil
    self.access_count = 0 if access_count.nil?
  end

end
