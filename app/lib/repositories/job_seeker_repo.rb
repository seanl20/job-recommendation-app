# frozen_string_literal: true

module Repositories
  class JobSeekerRepo
    def create(attrs)
      ActiveRecord::Base.transaction do
        job_seeker = JobSeekers::JobSeeker.create!(JobSeekers::Changesets::Create.map(attrs))
        create_job_seeker_skills(job_seeker:, skills: attrs[:skills])
      end
    end

    def job_seekers
      JobSeekers::JobSeeker.includes(:job_seeker_skills).all
    end

    private

    def create_job_seeker_skills(job_seeker:, skills:)
      skills.split(", ").map do |skill|
        job_seeker.job_seeker_skills.create!(skill:)
      end
    end
  end
end