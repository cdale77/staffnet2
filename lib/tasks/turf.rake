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
                        Email1
                        Email2
                        Mobile
                        MobileBad
                        Home
                        HomeBad
                        Alt
                        AltBad
                        ContactType
                        ProspectGroup
                        Notes
                        DoNotEmail
                        DoNotCall
                        DoNotMail
                        DonationsCount
                        DonationsAmount
                        IsSustainer ]

    donation_column_names = %W[ Source
                                Date
                                Amt
                                Type
                                Freq
                                SubMonth
                                Declined?
                                Canceled?
                                CC_Info
                                Notes ]


    ## Add donation columns for 5 donations to the column_names array
    (1..5).each do |i|
      donation_column_names.each do |donation_column|
        column_names << "Donation#{i}_#{donation_column}"
      end
    end


    # generate the CSV file
    puts "Generating the CSV file. This might take a while."
    csv_file = CSV.generate do |csv_row|

      # write the column names
      csv_row << column_names

      Supporter.find_each do |supporter|

        donations = supporter.donations.limit(5)

        donations_count = donations.count.to_s
        donations_amount = donations.map(&:total_value).inject(0, &:+)

        #set the initial supporter fields array
        supporter_fields = [  supporter.id.to_s,
                              supporter.full_name,
                              supporter.address1,
                              supporter.address2,
                              supporter.address_city,
                              supporter.address_state,
                              supporter.address_zip,
                              supporter.email_1,
                              supporter.email_2,
                              supporter.phone_mobile,
                              supporter.phone_mobile_bad,
                              supporter.phone_home,
                              supporter.phone_home_bad,
                              supporter.phone_alt,
                              supporter.phone_alt_bad,
                              supporter.supporter_type.name,
                              supporter.prospect_group,
                              supporter.notes,
                              supporter.do_not_email,
                              supporter.do_not_call,
                              supporter.do_not_mail,
                              donations_count,
                              donations_amount,
                              supporter.is_sustainer? ]

        donations.each do |donation|

          # look up the most recent payment
          payment = donation.payments.first
          profile = payment ? payment.payment_profile : PaymentProfile.new
          cc_info = profile ? profile.short_version : ""

          donation_fields =  [  donation.source,
                                donation.date,
                                donation.amount,
                                donation.donation_type,
                                donation.frequency,
                                donation.sub_month,
                                !donation.captured,
                                donation.cancelled,
                                cc_info,
                                donation.notes ]

          # add the donations fields to the supporter fields array
          donation_fields.each { |field| supporter_fields << field }
        end

        # add the fields to the CSV object
        csv_row << supporter_fields
      end
    end

    ## Write the file to the filesystem.
    file_name = "all_supporters-#{Date.today}.csv"
    File.open(file_name,'wb') do |f|
      f.write csv_file
    end
  end
end
