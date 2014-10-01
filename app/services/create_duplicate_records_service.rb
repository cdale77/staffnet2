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

  # exposed for testing
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
    primary_record = record_array.shift # grab the first record. 
    primary_record_id = primary_record["*supporterid*"]
    duplicate_record_ids = record_array.map { |r| r["*supporterid*"] }
    DuplicateRecord.create!(record_type: "supporter", 
                              primary_record_id: primary_record_id,
                              duplicate_record_ids: duplicate_record_ids)
  end

  private 

    def download_file
      open(URI.parse(@file_uri))
    end

    def csv_import_options
      {
          #chunk_size: chunk_size,
          strip_whitespace: true,
          strings_as_keys: true,
          remove_empty_values: false
          #remove_unmapped_keys: true,
          #key_mapping: @import_mapping.mappings
      }
    end
end
