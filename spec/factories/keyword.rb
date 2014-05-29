FactoryGirl.define do
  factory :keyword do
    name "registration"
    metaphone ["RJST", "RKST"]
    stem "regist"
    synonyms ['enrollment', 'enrolment', 'adjustment', 'readjustment', 'body', 'calibration', 'certificate', 'certification', 'credential', 'credentials', 'entering', 'entrance', 'entry', 'incoming', 'ingress', 'sound property', 'standardisation', 'standardization']
  end
end
