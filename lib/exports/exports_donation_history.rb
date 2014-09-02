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
                                    IsSustainer ]

    @@donation_column_names = %W[ Source
                                  Date
                                  Amt
                                  Type
                                  Freq
                                  SubMonth
                                  Declined?
                                  Canceled?
                                  CC_Info
                                  Notes ]

    def self.column_names
      column_names = @@supporter_column_names
      (1..5).each do |i|
        @@donation_column_names.each do |donation_column|
          column_names << "Donation#{i}_#{donation_column}"
        end
      end
      return column_names
    end

    def perform

    end
  end
end