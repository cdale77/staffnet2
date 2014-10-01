class CreateDuplicateRecordsService < ServiceBase 

  BASE_URI = "https://#{ENV["UPLOAD_BUCKET"]}.s3.amazonaws.com"
  require "open-uri"

  def initialize(file_path)
    @file_uri = "#{BASE_URI}#{file_path}"
  end

  def perform 
    open(@file_uri) do |f|
      f.each_line do |line|
        puts "#{line}"
      end 
    end
  end

end
