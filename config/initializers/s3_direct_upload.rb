S3DirectUpload.config do |c|
  c.access_key_id     = ENV["AWS_ACCESS_KEY_ID"]
  c.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
  c.bucket            = ENV["UPLOAD_BUCKET"]
  c.region            = "s3-us-east-1"
  c.url               = "https://#{c.bucket}.s3.amazonaws.com/"
end