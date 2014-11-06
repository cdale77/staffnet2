module ExportTemplate
  module Excel
    class Workbook

      def initialize
        @worksheet_template = ExportTemplate::Excel::Worksheet.new
      end
 
      def export_file
        "#{header}" \
        "#{@worksheet_template.worksheet}" \
        "#{footer}"
      end

      private
        def header
          '<?xml version="1.0"?>\n' \
            '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"\n' \
            'xmlns:o="urn:schemas-microsoft-com:office:office"\n' \
            'xmlns:x="urn:schemas-microsoft-com:office:excel"\n' \
            'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"\n'
            'xmlns:html="http://www.w3.org/TR/REC-html40">]\n'
        end

        def footer
          '</Workbook>'
        end
    end

  end
end
