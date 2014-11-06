module ExportTemplate
  module Excel
    class Worksheet

      def initialize(model_name: "",
                     id_array: [],
                     column_names: [],
                     column_methods: [])
        @model_name = model_name
        @id_array = id_array
        @column_names = column_names
        @column_methods = column_methods
      end

      def worksheet
        "#{header}#{column_headers}#{footer}"
      end

      private

        def column_headers
          header_row = '<Row>'
          @column_names.each { |name| header_row << build_row(name) }
          header_row << '</Row>'
          return header_row
        end

        def header(name: "Sheet1")
          '<Worksheet ss:Name="' + name + '">' \
            '<Table>'
        end

        def footer
          '</Table>' \
          '</Worksheet>'
        end

        def build_row(data)
          '<Cell><Data ss:Type="String">' + data + '</Data></Cell>'
        end
    end
  end
end
