class DonationHistoryReportService < ServiceBase
  require 'axlsx'

  def perform
    p = Axlsx::Package.new
    workbook = p.workbook

    workbook.add_worksheet(name: "DonationHistory") do |sheet|
      sheet.add_row column_names
      Supporter.find_each { |s| sheet.add_row build_row(s) }
    end

    return p.to_stream # returns a StringIO, good for paperclip
  end

  private

    def column_names
      column_names = supporter_column_names
      (1..5).each do |i|
        donation_column_names.each do |donation_column|
          column_names << "Donation#{i}_#{donation_column}"
        end
      end
      return column_names
    end

    def build_row(supporter)
      row = build_supporter_data(supporter)
      supporter.donations.limit(5).each do |donation|
        build_donation_data(donation).each do |field|
          row << field
        end
        build_misc_data(donation, donation.payments.first).each do |field|
          row << field
        end
      end
      return row
    end

    def build_supporter_data(supporter)
      supporter_data_methods.map do |method|
        supporter.public_send(method.to_s)
      end
    end

    def build_donation_data(donation)
      donation_data_methods.map do |method|
        donation.public_send(method.to_s)
      end
    end

    def build_misc_data(donation = Donation.new, payment = Payment.new)
      [donation_employee_name(donation), payment_profile_info(payment)]
    end

    def supporter_column_names
      %w[ SupporterID
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
    end

    def donation_column_names
      %w[ Source
          Date
          Amt
          Type
          Freq
          SubMonth
          Captured?
          Canceled?
          Notes
          EmployeeName
          CCInfo ]
    end

    def supporter_data_methods
      %w[ id
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
    end

    def donation_data_methods
      %w[ source
          date
          amount
          donation_type
          frequency
          sub_month
          captured
          cancelled
          notes ]
    end

    def donation_employee_name(donation)
      if donation.shift && donation.shift.employee
        donation.shift.employee.full_name
      else
        ""
      end
    end

    def payment_profile_info(payment)
      profile = payment.payment_profile if payment
      profile ? profile.short_version : ""
    end
end

