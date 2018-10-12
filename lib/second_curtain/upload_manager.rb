require 'second_curtain/upload'
require 'second_curtain/web_preview'
require 'fileutils'

class UploadManager
  def initialize
    @uploads = []
  end

  def enqueue_upload(expected_path, actual_path)
    @uploads.push(Upload.new(expected_path, actual_path))
  end

  def upload(folder_name)
    return nil unless @uploads.count > 0

    FileUtils.rm_rf(folder_name) if Dir.exists?(folder_name)
    FileUtils.makedirs(folder_name)

    @uploads.each do |upload|
      upload.upload(folder_name)
    end

    preview = WebPreview.new(@uploads)
    preview_file = folder_name + "/index.html"
    File.write(preview_file, preview.generate_html)
    preview_file
  end
end
