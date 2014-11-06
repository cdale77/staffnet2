module ExportTemplate
  module Excel
    class Workbook

      def header
        '<?xml version="1.0"?> ' \
          '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" ' \
          'xmlns:o="urn:schemas-microsoft-com:office:office" ' \
          'xmlns:x="urn:schemas-microsoft-com:office:excel" ' \
          'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" ' \
          'xmlns:html="http://www.w3.org/TR/REC-html40">] '
      end

      def footer
        '</Workbook>'
      end
    end
  end
end

