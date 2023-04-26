# frozen_string_literal: true

class DoiProcessorService
  def process(expression, results)
    results.each do |r|
      response = r['response']
      doi_string = response['doi']
      title = response['title']
      pdf_url = response['best_oa_location']['url_for_pdf']
      author = nil
      if response['z_authors'].present?
        z_authors = response['z_authors'].map{|a| "#{a['family']}, #{a['given']}"}
        author = z_authors.join(", ")
      end
      snippet = r['snippet']
      puts "#{doi_string} - #{pdf_url}"
      doi_rec = Doi.find_by(expression: expression, doi: doi_string)
      if doi_rec.nil?
        doi_rec = Doi.new(expression: expression,
                          doi: doi_string,
                          title: title,
                          snippet: snippet,
                          authors: author)
        if doi_rec.save
          PdfReaderJob.perform_later(doi_rec.id, pdf_url)
        end
      else
        doi_rec.update(expression: expression,
                       doi: doi_string,
                       title: title,
                       snippet: snippet,
                       authors: author)
        PdfReaderJob.perform_later(doi_rec.id, pdf_url)
      end
    end
  end
end