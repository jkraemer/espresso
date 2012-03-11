module Espresso
  class Asset < ActiveRecord::Base
    include Espresso::Engine.routes.url_helpers
    include ActionView::Helpers::NumberHelper

    attr_accessible :title, :file, :remote_file_url, :file_cache
    mount_uploader :file, AssetUploader

    validates :file, :presence => true
    validates :file_size, :numericality => { :greater_than => 0 }

    scope :by_date, order('created_at DESC')

    def full_file_url(request)
      URI::Generic.build(scheme:request.scheme, host:request.host, port:request.port, path:file_url).to_s
    end

    def to_jq_upload(request)
      {
        "name" => read_attribute(:file),
        "size" => number_to_human_size(file_size),
        "url" => full_file_url(request),
        "thumbnail_url" => file.thumb.url,
        "edit_url" => edit_asset_path(self),
        "delete_url" => asset_path(self),
        "updated_at" => I18n.l(updated_at, :format => :long)
      }
    end
  end
end
