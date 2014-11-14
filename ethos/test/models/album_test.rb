require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  should belong_to(:ideaboard)
end
