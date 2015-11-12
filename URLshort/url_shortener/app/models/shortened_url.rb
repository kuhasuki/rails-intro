class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :uniqueness => true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: "Visit"

  has_many :visitors,
    through: :visits,
    source: :user

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_url = ShortenedUrl.new user_id: user.id, long_url: long_url
    new_url.short_url = ShortenedUrl.random_code
    new_url.save!
  end

  def num_clicks
    Visit.where(url_id: id).count
  end

  def num_uniques
    Visit.select(:visitor_id).where(url_id: id).distinct.count
  end

  def num_recent_uniques
    Visit.select(:visitor_id)
    .where("url_id = ? and created_at >= ?", id, 1000.minutes.ago)
    .distinct
    .count
  end

end
