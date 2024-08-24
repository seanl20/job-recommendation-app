# frozen_string_literal: true

module Repositories
  class JobRepo
    def create(attrs)
      ActiveRecord::Base.transaction do
        job_seeker = Jobs::Job.create!(Job::Changesets::Create.map(attrs))
        create_job_required_skills(job_seeker:, skills: attrs[:required_skills])
      end
    end

    def jobs
      Jobs::Job.includes(:required_skill).all
    end

    private

    def create_job_required_skills(job:, required_skills:)
      required_skills.split(", ").map do |required_skill|
        job_seeker.job_required_skills.create!(required_skill:)
      end
    end
  end
end