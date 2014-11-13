class DatabaseReportService < ServiceBase

  def perform
    p = Axlsx::Package.new
    workbook = p.workbook

    export_models.each do |model|
      workbook.add_worksheet(name: "#{model.name.pluralize.downcase}") do |sheet|
        sheet.add_row model.column_names
        model.find_each(batch_size: 25) do |record|
          sheet.add_row record.attributes.values
          record = nil #explicity destroy the object to save some memory
        end

      end
    end
    return p.to_stream # returns a StringIO, good for paperclip
  end

  private
    def export_models
      Rails.application.eager_load! unless Rails.env.production?
      ActiveRecord::Base.descendants.select { |model| model.name.exclude?("::") }
    end
end

