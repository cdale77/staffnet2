class DuplicateRecordsController < ApplicationController 

  #@@s3_bucket = S3_BUCKET = AWS::S3.new.buckets[ENV["DULPICATE_REPORT_BUCKET"]]

  include Pundit 
  after_filter :verify_authorized 
  skip_before_filter :verify_authenticity_token

  def new_batch 
    @new_batch = DuplicateRecord.new # just making an object for Pundit
    #@s3_direct_post = @@s3_bucket.presigned_post(
    #  key: "uploads/#{SecureRandom.uuid}/${filename}", 
     # success_action_status: 201, acl: :public_read)
    authorize @new_batch
  end
end
