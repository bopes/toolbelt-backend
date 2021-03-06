class User < ActiveRecord::Base

  has_many :ratings_received, class_name: "Rating", foreign_key: "ratee_id"
  has_many :ratings_given, class_name: "Rating", foreign_key: "rater_id"
  has_many :raters, through: :ratings_received, source: :rater
  has_many :ratees, through: :ratings_given, source: :ratee

  has_many :flags_received, class_name: "Flag", foreign_key: "flagee_id"
  has_many :flags_given, class_name: "Flag", foreign_key: "flagger_id"
  has_many :flaggers, through: :flags_received, source: :flagger
  has_many :flagees, through: :flags_given, source: :flagee

  has_many :tools

  validates :first_name, :last_name, :email, presence: true
  validates :state, length: {maximum: 2}
  validates :email, uniqueness: true

  before_save :find_coordinates

  def find_coordinates
    full_address = ""
    if self.street_address_2 != nil
      full_address = "#{self.street_address_1}, #{self.street_address_2}, #{self.city}, #{self.state}, #{self.zip}"
    else
      full_address = "#{self.street_address_1}, #{self.city}, #{self.state}, #{self.zip}"
    end
    geo_pos = Geokit::Geocoders::GoogleGeocoder.geocode full_address
    coor = geo_pos.ll.split(",")
    self.latitude = coor[0].to_f
    self.longitude = coor[1].to_f
  end

end
