require 'open-uri'

class PdfReaderJob < ApplicationJob
  queue_as :default

  def perform(id, file_url)
    # binding.irb
    puts "#{id} - #{file_url}"
    doi_rec = Doi.find(id)
    begin
      io = open(file_url)
      reader = PDF::Reader.new(io)
      contents = render.pages.map{ |page| page.text }
      doi_rec.update(contents: contents.join(''))
    rescue => exception
      doi_rec.update(contents: 'N/A')
    end
    puts "#{id} - #{file_url} - DONE"
    # Do something later
  end
end
