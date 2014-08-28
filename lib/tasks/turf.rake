require "csv"
desc "Scripts to export supporter data for calling or other contact."

namespace :turf do



  task all: :environment do

    ## Amazon S3 connection
    s3_connection = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )


  end
end