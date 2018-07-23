require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @addr = Address.new(street_name: "888 ABC St", city: "SFO",
                     state: "CA", zip_5: "92602")
  end

  test "should be valid" do
    assert @addr.valid?
  end
  
  test "street_name should be present" do
    @addr.street_name = "     "
    assert_not @addr.valid?
  end
  
  test "city should be present" do
    @addr.city = "     "
    assert_not @addr.valid?
  end

  test "state should be present" do
    @addr.state = "     "
    assert_not @addr.valid?
  end
  
  test "postal code should be present" do
    @addr.zip_5 = "     "
    assert_not @addr.valid?
  end

  test "state should be 2 letters" do
    @addr.state = "California"
    assert_not @addr.valid?
  end

  test "postal code should 5 digits only" do
    @addr.zip_5 = "11111111"
    assert_not @addr.valid?
  end
 
