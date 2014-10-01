class CreateDuplicateRecordsService < ServiceBase 

  BASE_URI = "https://#{ENV["UPLOAD_BUCKET"]}.s3.amazonaws.com"
  require "open-uri"

  def initialize(file_path)
    @file_uri = "#{BASE_URI}#{file_path}"
  end

  def perform 

    # must read the full file into memory, to group it into chunks based
    # on dupe pair ids
    file = SmarterCSV.process(open(URI.parse(@file_uri)),
                       csv_import_options)

    dupe_sets = file.group_by { |line| line["no."] }

    dupe_sets.each do |set|
      records = set.second #an array of the actual dupe record hashes
      primary_record_id = records.first["*supporterid*"]
      records.shift
      duplicate_record_ids = records.map { |r| r["*supporterid*"] }
      DuplicateRecord.create!(record_type: "supporter", 
                              primary_record_id: primary_record_id,
                              duplicate_record_ids: duplicate_record_ids)
    end
  end

  private 

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
