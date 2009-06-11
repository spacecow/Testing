require File.dirname(__FILE__) + '/../../test_helper'
require 'action_view/test_case'
class KlassesHelperTest < ActionView::TestCase
  context "The date parser" do
	  should "return the correct year, month and day" do
	    (year,month) = parse_date( Date.parse( "2009-06-07" ).to_s )
	    assert_equal year, 2009
	  end
	end
end
