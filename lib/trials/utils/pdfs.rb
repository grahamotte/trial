def pdf_to_text(path)
  `pdftotext "#{seed_path(path)}" #{tmp_path('tmp_pdf.txt')}; \
  cat #{tmp_path('tmp_pdf.txt')}`
end
