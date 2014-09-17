require "spec_helper"
include ActionView::Helpers::NumberHelper
include ActionView::Helpers::UrlHelper

describe EmployeePresenter do

  let!(:user) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee,
                                        user: user) }
  let!(:presenter) { EmployeePresenter.new(employee) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of EmployeePresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Employee
    end
  end

  describe '#email_link' do
    it 'should return a link to the email' do
      expect(presenter.email_link).to eq \
        mail_to(employee.email, nil, class: "hover-underline-grey")
    end
  end

  describe '#formatted_phone' do
    it 'should return the formatted phone number' do
      expect(presenter.formatted_phone).to eq \
        number_to_phone(employee.phone.to_i)
    end
  end

  describe '#fed_status_to_human' do
    it 'should humanize the value' do
      expect(presenter.fed_status_to_human).to eq \
        employee.fed_filing_status.humanize
    end
  end

  describe '#ca_status_to_human' do
    it 'should humanize the value' do
      expect(presenter.ca_status_to_human).to eq \
        employee.ca_filing_status.humanize
    end
  end

  describe '#title_to_human' do
    it 'should humanize the value' do
      expect(presenter.title_to_human).to eq employee.title.humanize
    end
  end

  describe '#formatted_hourly_pay' do
    it 'should format the number' do
      expect(presenter.formatted_hourly_pay).to eq \
        number_to_currency(employee.pay_hourly)
    end
  end

  describe '#formatted_daily_pay' do
    it 'should format the number' do
      expect(presenter.formatted_daily_pay).to eq \
      number_to_currency(employee.pay_daily)
    end
  end

  describe '#formatted_dob' do
    it 'should format the date' do
      expect(presenter.formatted_dob).to eq I18n.l(employee.dob)
    end
  end

  describe '#formatted_hire_date' do
    it 'should format the date' do
      expect(presenter.formatted_hire_date).to eq I18n.l(employee.hire_date)
    end
  end

  describe '#formatted_term_date' do
    it 'should format the date' do
      expect(presenter.formatted_term_date).to eq I18n.l(employee.term_date)
    end
  end

  describe '#formatted_raised_lifetime' do
    it 'should format the number' do
      expect(presenter.formatted_raised_lifetime).to eq \
        number_to_currency(employee.raised_lifetime)
    end
  end

  describe '#formatted_average_lifetime' do
    it 'should format the number' do
      expect(presenter.formatted_average_lifetime).to eq \
      number_to_currency(employee.average_lifetime)
    end
  end

  describe '#formatted_raised_this_week' do
    it 'should format the number' do
      expect(presenter.formatted_raised_this_week).to eq \
        number_to_currency(employee.raised_this_week)
    end
  end

  describe '#formatted_average_this_week' do
    it 'should format the number' do
      expect(presenter.formatted_average_this_week).to eq \
      number_to_currency(employee.average_this_week)
    end
  end

  describe '#formatted_status' do
    it 'should format the status' do
      expect(presenter.formatted_status).to eq "Active"
    end
  end
end