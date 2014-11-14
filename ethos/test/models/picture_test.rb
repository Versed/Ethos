require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  should belong_to(:album)
end
