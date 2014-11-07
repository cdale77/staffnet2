module Exports
  class DonationHistory < Exports::Base


    @@supporter_column_names = %W[  SupporterID
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
                                    IsSustainer
                                    VolLevel
                                    IssueKnowledge ]

    @@donation_column_names = %W[ Source
                                  Staff
                                  Date
                                  Amt
                                  Type
                                  Freq
                                  SubMonth
                                  Declined?
                                  Canceled?
                                  CC_Info
                                  Notes ]

    @@supporter_field_value_methods = %w[ id
                                          full_name
                                          address1
                                          address2
                                          address_city
                                          address_state
                                          address_zip
                                          email_1
                                          email_2
                                          phone_mobile
                                          phone_mobile_bad
                                          phone_home
                                          phone_home_bad
                                          phone_alt
                                          phone_alt_bad
                                          supporter_type_name
                                          prospect_group
                                          notes
                                          do_not_email
                                          do_not_call
                                          do_not_mail
                                          donations_count
                                          donations_amount
                                          is_sustainer?
                                          vol_level
                                          issue_knowledge ]

    def self.column_names
      # returns the column names for a supporter record with five donation
      # columns

      column_names = @@supporter_column_names

      (1..5).each do |i|
        @@donation_column_names.each do |donation_column|
          column_names << "Donation#{i}_#{donation_column}"
        end
      end

      return column_names
    end

    def self.supporter_fields(supporter)
      supporter_fields = []
      @@supporter_field_value_methods.each do |method|
        supporter_fields << supporter.send(method)
      end
      return supporter_fields
    end

    def self.donation_fields(donation)
      # look up the most recent payment
      payment = donation.payments.first
      profile = payment ? payment.payment_profile : PaymentProfile.new
      cc_info = profile ? profile.short_version : ""
      staff_name = donation_employee_name(donation)

      [  donation.source,
         staff_name,
         donation.date,
         donation.amount,
         donation.donation_type,
         donation.frequency,
         donation.sub_month,
         !donation.captured,
         donation.cancelled,
         cc_info,
         donation.notes ]
    end

    def self.donation_employee_name(donation)
      if donation.shift && donation.shift.employee
        donation.shift.employee.full_name
      else
        ""
      end
    end

    def self.prospect_group(group_code)

      csv_file = CSV.generate do |csv_row|

        # write the column names
        csv_row << column_names

        Supporter.where(prospect_group: group_code).find_each do |supporter|

          puts "."

          donations = supporter.donations.limit(5)

          supporter_fields = self.supporter_fields(supporter)

          donations.each do |donation|

            donation_fields =  self.donation_fields(donation)

            # add the donations fields to the supporter fields array
            donation_fields.each { |field| supporter_fields << field }
          end

          # add the fields to the CSV object
          csv_row << supporter_fields
        end
      end

      # return a StringIO to make it easy to use PaperClip
      StringIO.new(csv_file)
    end

    def self.all

      csv_file = CSV.generate do |csv_row|

        # write the column names
        csv_row << column_names

        Supporter.find_each do |supporter|

          donations = supporter.donations.limit(5)

          supporter_fields = self.supporter_fields(supporter)

          donations.each do |donation|

            donation_fields =  self.donation_fields(donation)

            # add the donations fields to the supporter fields array
            donation_fields.each { |field| supporter_fields << field }
          end

          # add the fields to the CSV object
          csv_row << supporter_fields
        end
      end

      # return a StringIO to make it easyt to use PaperClip
      StringIO.new(csv_file)
    end
  end
end
