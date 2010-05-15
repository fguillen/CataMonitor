require 'test_helper'

class QueriesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Queries.new.valid?
  end
end
