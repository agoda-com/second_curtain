require 'mustache'

class WebPreview
  attr_reader :uploads

  def initialize(uploads)
    @uploads = uploads
  end

  def generate_html
    lib_path = File.expand_path(File.dirname(__FILE__))
    template = File.read(lib_path + "/template.mustache.html")

    Mustache.render(template, :uploads => @uploads)
  end
end
