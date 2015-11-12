class Visit < ActiveRecord::Base
  validates :visitor_id, :presence => true
  validates :url_id, :presence => true

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: "ShortenedUrl"

  belongs_to :user,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: "User"

  def self.record_visit!(user, shortened_url)
    visit = Visit.new visitor_id: user.id, url_id: shortened_url.id
    visit.save!
  end


end
