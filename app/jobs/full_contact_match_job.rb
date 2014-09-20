require "active_job"

class FullContactMatchJob < ActiveJob::Base

  queue_as :default


  def perform
    @retries = []
    major_donors = SupporterType.find_by(name: "major_donor").supporters

    major_donors.each do |donor|

      response = look_up_request(donor)

      process_response(response)

      sleep(1.5)

    end

    if @retries.count < 0
      sleep 120
      @retries.each do |id|
        donor = Supporter.find(id)

        response = look_up_request(donor)

        process_response(response)

      end
    end
  end

  def look_up_request(donor)
    # Decide how to look up the donor

    if donor.email_1.present?

    begin
      response = FullContact.person(email: donor.email_1)
    rescue
  
    end

    elsif donor.email_2.present?
    begin
      response = FullContact.person(email: donor.email_2)
    rescue
    end
    elsif donor.phone_mobile.present?
      begin
        response = FullContact.person(phone: donor.phone_mobile)
      rescue
      end
    elsif donor.phone_home.present?
      begin
      response = FullContact.person(phone: donor.phone_home)
      rescue
      end
    elsif donor.phone_alt.present?
      begin
      response = FullContact.person(phone: donor.phone_alt)
      rescue
      end
    end

    return response if response
  end

  def process_response(response)
    if response && response.is_a?(Hashie::Rash) && response["status"] == 200

      donor.full_contact_matches.create(payload: response)

    elsif response["status"] == 202
      @retries << donor.id
    end
  end
end
