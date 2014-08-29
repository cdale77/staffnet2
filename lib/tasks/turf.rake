require "csv"
desc "Scripts to export supporter data for calling or other contact."

namespace :turf do



  task all: :environment do
    desc "Produce a report of all the supporters"

    puts "Building list of #{Supporter.count} supporters."

    ## Column names
    column_names = %W[  SupporterID
                        Name
                        Address
                        Address2
                        City
                        State
                        Zip
                        Email
                        Mobile
                        Home
                        Work
                        Donor?
                        Political?
                        VolunteerLevel
                        ProspectGroup
                        Notes
                        NoGoodPhone
                        DoNotContact
                        DoNotCall
                        DoNotMail
                        DonationsCount
                        DonationsAmount
                        IsSupporterSustainer ]

    donation_column_names = %W[ Source
                                Date
                                Amt
                                Type
                                Freq
                                Freq_Code
                                Declined?
                                Canceled?
                                CC_Type
                                CC_Info
                                Notes ]


    ## Add donation columns for 5 donations to the column_names array
    (1..5).each do |i|
      donation_column_names.each do |donation_column|
        column_names << "Donation#{i}_#{donation_column}"
      end
    end


    # generate the CSV file
    puts "Generating the CSV file"
    csv_file = CSV.generate do |csv_row|
      csv_row << column_names
    end

    ## Store the file on S3
    file_name = "all_supporters-#{Date.today}"
    puts "Storing on S3. Filename: #{file_name}"
    s3_connection = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                              secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    bucket = s3_connection.buckets["staffnet2-turf"]

    bucket.objects.create(file_name, csv_file)
  end
end