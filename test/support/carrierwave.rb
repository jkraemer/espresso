CarrierWave.configure do |config|
  config.enable_processing = false
end

# install some wrappers around the CarrierWave rspec matchers
class ActiveSupport::TestCase

  # checks wether the image has an exact size of x by y
  def assert_image_dimensions(image, x, y)
    m = CarrierWave::Test::Matchers::HaveDimensions.new(x, y)
    assert m.matches?(image), m.failure_message
  end

  # checks wether the image fits into a box with size x by y
  def assert_bounding_box(image, x, y)
    m = CarrierWave::Test::Matchers::BeNoLargerThan.new(x, y)
    assert m.matches?(image), m.failure_message
  end

end
