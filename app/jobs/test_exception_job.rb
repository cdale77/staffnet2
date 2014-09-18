require "active_job"

# This job is to test exception handling with Sidekiq

class TestExceptionJob < ActiveJob::Base
  queue_as :default

  def perform
    raise StandardError
  end
end