class PerformSendyUpdatesService < ServiceBase

  def perform
    SendyUpdate.where(success: false).find_each(batch_size: 250) do |update|
      puts "Performing update id #{update.id}"
      SendyUpdateJob.perform_later(update.id)
    end
  end
end

