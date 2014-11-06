module ExportTemplate
  module Excel
    class Worksheet

      def worksheet
        "#{header}#{footer}"
      end

      private
        def header(name: "Sheet1")
          '<Worksheet ss:Name="' + name + '">'
        end

        def footer
          '</Worksheet>'
        end
    end
  end
end
