require 'net/http'
require 'uri'
require 'json'

class Address < ApplicationRecord

  attr_accessor :street_address

	#validates :house_number, presence: true
  states_list = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
  validates :street_name, presence: true
  validates :city, presence: true
  validates :state, presence: true, format: { with: /\A[A-Z]{2}\z/, message: 'Should be 2 letter abbreviation' }
  validates_inclusion_of :state, :in => states_list, message: 'is invalid'
  validates :zip_5, presence: true, format: { with: /\A\d{5}\z/, message: 'Should be 5 digit code' }

  def to_s
    [house_number, street_postdirection, street_name, street_type, street_postdirection, unit_type, unit_number, city, state, zip_5].compact.join(', ')
  end

  validate :address_verification

  private

  def address_verification
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{self.to_s}&components=postal_code:#{zip_5}&key=AIzaSyAwEmr9Sriz7RBvOVqPe0j4HE8SzSzvLYE"
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    addr_status = JSON.parse(response)
    if addr_status['status'] != 'OK'
      self.errors.add(self.to_s, "is not valid")
    end
  end  

end
