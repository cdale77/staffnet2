class DonationHistoryReportService < ServiceBase

  def initialize
    super
    @workbook_template = ExportTemplate::Excel::Workbook.new
    @worksheet_template = ExportTemplate::Excel::Worksheet.new(
                                                    column_names: column_names)
  end

  def perform
    "#{@workbook_template.header}" \
    "#{@worksheet_template.worksheet}" \
    "#{@workbook_template.footer}"
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
    end

    def column_methods
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
end

