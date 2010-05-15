require 'test_helper'

class MentionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Mention.new.valid?
  end
end
