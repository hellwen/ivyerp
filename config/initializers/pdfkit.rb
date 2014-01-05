PDFKit.configure do |config|
#  config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  config.default_options = {
    :page_size => 'A4',
    :print_media_type => true,
    #:ignore_load_errors => true,
  }

  config.root_url = "http://localhost"

  #ActionController::Base.asset_host = Proc.new { |source, request|
  #  if request.format.pdf?
  #    "#{request.protocol}#{request.host_with_port}"
  #  else
  #    nil
  #  end
  #}
end
