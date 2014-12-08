class PerformSendyUpdatesService < ServiceBase

  def perform
    SendyUpdate.where(success: false).find_each(batch_size: 250) do |update|
      begin
        klass = "Sendy#{update.action.classify}Job".constantize
        klass.perform_later(update.id)
        puts "Performed update id #{update.id}"

        #horrible hack to avoid race conditions and keep things stable. When
        #processing > 50 updates or so sometimes successful updates are not
        #marked as successful. I think it's because Sendy does not return
        #success, but still grabs the data, when it's hit too fast
        sleep 5
      rescue
        puts "Error on update id #{update.id}"
      end
    end
  end
end

