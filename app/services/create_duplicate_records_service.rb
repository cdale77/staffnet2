class CreateDuplicateRecordsService < ServiceBase 

  BASE_URI = "https://#{ENV["UPLOAD_BUCKET"]}.s3.amazonaws.com"
  require "open-uri"

  def initialize(file_path)
    @file_uri = "#{BASE_URI}#{file_path}"
  end

  # This is the main method to be called
  def perform 
    process_file(download_file)
  end

  private 

    def process_file(file) 

      # must read the full file into memory, to group it into chunks based
      # on dupe pair ids
      data = SmarterCSV.process(file, csv_import_options)

      dupe_sets = data.group_by { |line| line["no."] }

      dupe_sets.each do |set|
        create_database_records(set.second) 
      end
    end

    def create_database_records(record_array)
      first_record = record_array.shift # grab the first record. 
      first_record_id = first_record["*supporterid*"]
      additional_record_ids = record_array.map { |r| r["*supporterid*"] }
      DuplicateRecord.create!(record_type_name: "supporter", 
                              first_record_id: first_record_id,
                              additional_record_ids: additional_record_ids)
    end

    def download_file
      open(URI.parse(@file_uri))
    end

    def csv_import_options
      {
          strip_whitespace: true,
          strings_as_keys: true,
          remove_empty_values: false
      }
    end
end
