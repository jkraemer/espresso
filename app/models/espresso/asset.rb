module Espresso
  class Asset < ActiveRecord::Base
    attr_accessible :title, :file, :remote_file_url, :file_cache
    mount_uploader :file, AssetUploader

    validates :file, :presence => true
    validates :file_size, :numericality => { :greater_than => 0 }

    scope :by_date, order('created_at DESC')

  end
end
