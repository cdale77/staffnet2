module  Regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ALPHA_ONLY_REGEX = /\A[a-z]+\z/i
  STATE_REGEX = /\A[A-Z]{2}\z/
  GENDER_REGEX = /\A[mf]\z/i
  PHONE_REGEX = /\A\d{10}\z/
  ZIP_REGEX = /\A\d{5}\z/
  LAST_4_CC_REGEX = /\A[0-9]{3,4}\z/
end