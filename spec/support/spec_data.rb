module SpecData

  def self.deposit_batch_attributes
    {   date: Date.today,
        deposited: false,
        approved: false,
        receipt_number: "2323002323232",
        batch_type: "installment" }
  end

  def self.donation_attributes
    { date: "2012/12/10",
      donation_type: "Ongoing",
      source: "Mail",
      campaign: "Energy",
      frequency: "Quarterly",
      sub_month: "m",
      sub_week: 3,
      amount: 10.00,
      cancelled: false,
      notes: "Notes" }
  end

  def self.employee_attributes
    { first_name: "Test",
      last_name: "Employee",
      email: "test_employee@example.com",
      phone: "4155551234",
      address1: "2017 Mission St.",
      address2: "2nd Fl",
      address_city: "San Francisco",
      address_state: "CA",
      address_zip: "94110",
      title: "Field Manager",
      pay_hourly: 12,
      hire_date: Date.today,
      fed_filing_status: "single",
      ca_filing_status: "single",
      fed_allowances: 2,
      ca_allowances: 2,
      dob: Date.today,
      gender: "f",
      active: true,
      notes: "Notes",
      legacy_id: "34",
      shifts_lifetime: 0.0,
      shifts_this_pay_period: 0.0,
      shifts_this_week: 0.0,
      fundraising_shifts_lifetime: 0.0,
      fundraising_shifts_this_pay_period: 0.0,
      fundraising_shifts_this_week: 0.0,
      donations_lifetime: 0.0,
      donations_this_pay_period: 0.0,
      donations_this_week: 0.0,
      successful_donations_lifetime: 0.0,
      successful_donations_this_pay_period: 0.0,
      successful_donations_this_week: 0.0,
      raised_lifetime: 0.0,
      raised_this_pay_period: 0.0,
      raised_this_week: 0.0,
      average_lifetime: 0.0,
      average_this_pay_period: 0.0,
      average_this_week: 0.0 }
  end

  def self.paycheck_attributes
    {   check_date: Date.today,
        shift_quantity: 80,
        cv_shift_quantity: 74,
        quota_shift_quantity: 80,
        office_shift_quantity: 16,
        sick_shift_quantity: 0,
        vacation_shift_quantity: 0,
        holiday_shift_quantity: 0,
        total_deposit: 9876,
        gross_fundraising_credit: 10764,
        notes: "some note",
        credits: 45.00,
        docks: 25.00,
        total_quota: 1500,
        net_fundraising_credit: 10500,
        over_quota: -4500,
        temp_buffer: -300,
        bonus_credit: -400, }
  end

  def self.payment_profile_attributes
    {  supporter_id: 21,
       cim_payment_profile_id: "32323223",
       payment_profile_type: "credit",
       cc_last_4: "1111",
       cc_type: "visa",
       cc_month: "10",
       cc_year: "2017",
       cc_number: "4111111111111111" }
  end

  def self.payment_attributes
    {  deposited_at: Time.now,
       payment_type: "Credit Card",
       captured: true,
       processed: true,
       cim_transaction_id: "112131231",
       cim_auth_code: "12312312423",
       amount: 10.00,
       notes: "Notes" }
  end

  def self.payroll_attributes
    {   start_date: (Date.today - 2.weeks),
        end_date: Date.today,
        check_quantity: 8,
        shift_quantity: 80,
        cv_shift_quantity: 74,
        quota_shift_quantity: 80,
        office_shift_quantity: 16,
        sick_shift_quantity: 0,
        vacation_shift_quantity: 0,
        holiday_shift_quantity: 0,
        total_deposit: 9876,
        gross_fundraising_credit: 10764,
        notes: "some note",
        net_fundraising_credit: 10500 }
  end

  def self.sendy_list_attributes
    { supporter_type_id: 3,
      sendy_list_identifier: "232radsqwer145ef434p98y5",
      name: "supporters" }
  end

  def self.sendy_update_attributes
    { supporter_id: 34,
      sendy_batch_id: 34,
      action: "subscribe",
      success: true,
      sendy_email: "example@example.com",
      new_sendy_email: "example2@example.com",
      completed_at: Time.now,
      new_sendy_status: "subscribed" }
  end

  def self.shift_attributes
    {  date: Date.today,
       time_in: Time.now - 4.hours,
       time_out: Time.now,
       break_time: 30,
       notes: "Great shift",
       travel_reimb: 12.50,
       legacy_id: "56",
       reported_raised: 335,
       reported_cash_qty: 2,
       reported_cash_amt: 25,
       reported_check_qty: 1,
       reported_check_amt: 100,
       reported_one_time_cc_qty: 1,
       reported_one_time_cc_amt: 50,
       reported_monthly_cc_qty: 1,
       reported_monthly_cc_amt: 10,
       reported_quarterly_cc_qty: 2,
       reported_quarterly_cc_amt: 30,
       reported_total_yes: 7,
       site: "94709" }
  end

  def self.supporter_attributes
    {  external_id: "3421",
       cim_id: "43300134",
       supporter_type_id: 1,
       prefix: "Mr.",
       salutation: "Bob",
       first_name: "William",
       last_name: "Taft",
       suffix: "III",
       address1: "44 Winter Street",
       address2: "2nd Floor",
       address_city: "Boston",
       address_state: "MA",
       address_zip: "02010",
       email_1: "bob@example.com",
       email_2: "bobtaft@example.com",
       phone_mobile: "5554859875",
       phone_home: "5559007845",
       phone_alt: "5558874952",
       keep_informed: true,
       vol_level: "prospect",
       employer: "Ohio State University",
       occupation: "Professor",
       source: "door",
       notes: "Note.",
       sendy_updated_at: Time.now,
       sendy_status: "subscribed",
       sendy_list_id: 3,
       address_county: "Alameda",
       cim_customer_id: "100024",
       spouse_name: "John",
       prospect_group: "c",
       issue_knowledge: 2 }
  end

  def self.user_attributes 
    { email: "test@example.com",
      password: "foobar7878",
      password_confirmation: "foobar7878",
      role: "manager" }
  end
end