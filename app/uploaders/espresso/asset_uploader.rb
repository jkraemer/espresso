# encoding: utf-8

require 'carrierwave/processing/mime_types'

module Espresso
  class AssetUploader < CarrierWave::Uploader::Base
    include CarrierWave::MimeTypes

    storage :file

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    process :set_content_type

    version :thumb, :if => :is_image? do
      process :resize_to_fill => [50, 50]
    end

    version :large_thumb, :if => :is_image? do
      process :resize_to_fill => [160, 120]
    end

    version :medium, :if => :is_image? do
      process :resize_to_fit => [400, 300]
    end

    version :large, :if => :is_image? do
      process :resize_to_fit => [800, 600]
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    # def extension_white_list
    #   %w(jpg jpeg gif png)
    # end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

    before :cache, :capture_attributes # callback, example here: http://goo.gl/9VGHI
    def capture_attributes(new_file)
      model.file_size = File.size new_file.path
      model.title = new_file.filename if model.title.blank?
      model.content_type = new_file.content_type
      if is_image?(model)
        model.width, model.height =
          `identify -format "%wx%h" #{new_file.path}`.split(/x/) 
      end
    end

    def is_image?(asset)
      asset.content_type =~ /image/
    end

  end
end
