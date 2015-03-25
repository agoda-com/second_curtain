require 'date'
require 'pathname'
require 'uri'
require 'FileUtils'

class Upload
  attr_reader :expected_path
  attr_reader :actual_path
  attr_accessor :uploaded_expected_url
  attr_accessor :uploaded_actual_url

  def initialize(expected_path, actual_path)
    @expected_path = expected_path
    @actual_path = actual_path
  end

  def upload(path)
    abort unless path

    expected_filename = Pathname.new(@expected_path).basename.to_s
    expected_object = path + "/" + expected_filename
    FileUtils.cp(@expected_path, path)
    @uploaded_expected_url = expected_filename

    actual_filename = Pathname.new(@actual_path).basename.to_s
    actual_object = path + "/" + actual_filename
    FileUtils.cp(@actual_path, path)
    @uploaded_actual_url = actual_filename
  end
end
