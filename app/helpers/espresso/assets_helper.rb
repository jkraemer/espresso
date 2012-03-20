module Espresso
  module AssetsHelper
    def small_thumb(asset)
      thumbnail asset, :thumb, 50
    end

    def large_thumb(asset)
      thumbnail asset, :large_thumb, 120
    end


    def thumbnail(asset, size_type, size_px)
      url = asset.file.is_image?(asset) ?
        asset.file_url(size_type) :
        "http://www.stdicon.com/crystal/#{asset.content_type}?size=#{size_px}"
      link_to image_tag(url, :alt => asset.title),
              edit_asset_path(asset),
              :download => asset.full_file_url(request),
              :title => asset.title, :class => 'download'

    end
  end
end
