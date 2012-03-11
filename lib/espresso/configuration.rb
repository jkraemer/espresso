module Espresso
  class Configuration

    def initialize
      @image_processor = 'CarrierWave::MiniMagick'
    end

    # The name of the image processing module to be used with uploaded Images.
    #
    # The module specified here has to provide two methods:
    # resize_to_fill(width, height) (used to generate fixed size thumbnails)
    # resize_to_fit(width, height)  (used to downsize images for inline display)
    #
    # Defaults to CarrierWave::MiniMagick.
    attr_accessor :image_processor


    def apply!
      image_processor_module = image_processor.constantize
      Espresso::AssetUploader.class_eval do
        include image_processor_module
      end
    end
  end
end
