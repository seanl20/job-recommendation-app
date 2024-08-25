module JobSeekers
  module Queries
    class GetAll
      def call
        jobseekers = job_seekers_repo.job_seekers

        jobseekers.map do |jobseeker|
          {
            id: jobseeker.id,
            name: jobseeker.name,
            skills: jobseeker.job_seeker_skills.map(&:skill).join(", ")
          }
        end
      end

      private

      def job_seekers_repo
        Repositories::JobSeekerRepo.new
      end
    end
  end
end
