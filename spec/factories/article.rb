FactoryGirl.define do
  factory :article do
    title         "How do I get a driver license for the first time?"
    content_main  "Step 1: Get the appropriate form. Step 2: Fill out said form. Step 3: Profit."
    preview       "Go to a driver license station with your proof of legal presence, take a written exam there as well as eye test, photograph, and fingerprints, pay fees, and schedule a road test appointment."
    tags          "driver license, drivers license, driver's license, driving license, license, driving, drive, driving test, written test, written exam, driving exam, road test, road exam, new driver license, new driver's license, new driving license"
    status        "Published"

    factory :article_no_tags do
      tags ""
    end

    factory :article_random do
      title SecureRandom.hex(16)
    end
  end
end
