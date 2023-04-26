class PdfReaderJob < ApplicationJob
  queue_as :default

  def perform(id, file_url)
    # binding.irb
    # puts "#{id} - #{file_url}"
    # Do something later
  end
end
