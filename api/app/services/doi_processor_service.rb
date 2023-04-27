# frozen_string_literal: true

class DoiProcessorService
  def process(expression, results)
    results.each_with_index do |r, index|
      response = r['response']
      doi_string = response['doi']
      title = response['title']
      pdf_url = response['best_oa_location']['url_for_pdf']
      author = authors_names(response['z_authors'])
      snippet = r['snippet']
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

  def authors_names(authors_hash)
    if authors_hash.present?
      authors_array = authors_hash.map{|a| "#{a['family']}, #{a['given']}"}
      authors_array.join(", ")
    end
  end
end