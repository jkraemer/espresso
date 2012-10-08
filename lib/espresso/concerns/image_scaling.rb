module Espresso
  module Concerns
    # classes including this concern have to fulfill the following contract:
    # #unscaled_path has to return the path to the input file
    # #image? has to return true for any instance where the methods defined
    # here will be called
    # #width and #height have to return the image dimensions
    module ImageScaling
      extend ActiveSupport::Concern

      CONVERT = ['/usr/bin/convert',
                 '/usr/local/bin/convert',
                 '/opt/local/bin/convert'].detect{ |f| File.readable? f }

      included do
      end

      # scales this image, returns the scaled image data
      # raises an exception if this is not an image, returns false if scaling
      # failed for other reasons
      #
      # if height is nil it will be computed so the original aspect ratio is
      # retained, making cropping unnecessary.
      #
      # options are:
      # strip - strip meta data from image, defaults to true
      # progressive - build progressive jpeg, defaults to true 
      # quality - compression quality in %, defaults to 85,
      # crop - crop image to exactly fit the given dimensions? defaults to
      #   false if no height is given, otherwise defaults to true
      # output_type - defaults to 'jpg'
      def scale_to(new_width, new_height = nil, options = {})
        raise "cannot scale non-image" unless image?

        options.reverse_merge!(
          :strip => true,
          :progressive => true,
          :quality => 85,
          :crop => new_height.present?,
          :output_type => 'jpg'
        )
        new_height ||= scaled_height_keeping_aspect_ratio(new_width)

        (temp = Tempfile.new(['image-scaler', ".#{options[:output_type]}"])).close

        strip_meta = '-strip' if options[:strip]
        quality = "-quality #{options[:quality]}%"                                                              
        progressive = '-interlace Plane' if options[:progressive]
        crop = "^ -gravity center -extent #{new_width}x#{new_height}" if options[:crop]

        # -filter lanczos2sharp -distort resize ?                                             
        resize = "-resize #{new_width}x#{new_height}#{crop}"                                        
        cmd = "#{CONVERT} #{unscaled_path} #{resize} #{progressive} #{quality} #{strip_meta} #{temp.path}"
        result = `#{cmd}`                                                                     
        if File.readable?(temp.path) && File.size(temp.path) > 0                              
          return IO.read(temp.path) 
        else
          Rails.logger.error "scaling photo #{unscaled_path} failed:\n#{result}"                      
          false
        end
      end

      def scaled_height_keeping_aspect_ratio(width)
        (width.to_f / aspect_ratio).round
      end

      # returns the aspect ratio of this image
      def aspect_ratio
        raise "cannot compute aspect ratio of non-image" unless image?
        width.to_f / height.to_f
      end

      def filename
        File.basename unscaled_path
      end

    end
  end
end
