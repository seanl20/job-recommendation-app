FactoryBot.define do
  factory :job_seeker_skill, class: JobSeekers::JobSeekerSkill do
    association :job_seeker
    skill { "Rspec" }
  end
end
