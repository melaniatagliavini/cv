require 'wicked_pdf'

WickedPdf.config = {
  # exe_path: '/usr/local/bin/wkhtmltopdf',
  enable_local_file_access: true,
  print_media_type: true
  # user_style_sheet: ''
}

Jekyll::Hooks.register :site, :post_write do |site|
    site.pages.each do |page|
        if page.data['static_pdf']
          
            page.output.gsub! '../', site.dest + '/'
            pdf_path = site.dest + page.dir + page.data['pdf_name'] + '.pdf'

            pdf = WickedPdf.new.pdf_from_string(page.output, footer: {
              left: 'Curriculum Vitae '+ page.data['title'],
              right: '[page]/[topage]',
              font_name: 'Abel',
              font_size: 8
            })
            
            File.open(pdf_path, 'wb') do |file|
              file << pdf
            end
        end
    end
end 

Jekyll::Hooks.register :site, :post_read do |site|
  site.pages.each do |page|
    if page.data['title']
      page.data['pdf_name'] =  page.data['title'].split.join('_').downcase + '_cv' + (page.data['lang'] ? '_' + page.data['lang'] : '')
    end
  end
end 