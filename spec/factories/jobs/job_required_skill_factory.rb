FactoryBot.define do
  factory :job_required_skill, class: Jobs::JobRequiredSkill do
    association :job

    required_skill { "Rspec" }
  end
end
