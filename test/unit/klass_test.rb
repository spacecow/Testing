require File.dirname(__FILE__)+'/../test_helper'

class KlassTest < ActiveSupport::TestCase
  def test_find_same_klass
    date = Date.parse( "2009-06-02" )
    course = "入門 II"
    #find_same_klass( date, course )
  end
end