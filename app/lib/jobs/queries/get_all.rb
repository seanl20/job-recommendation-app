module Jobs
  module Queries
    class GetAll
      def call
        jobs = job_repo.jobs

        jobs.map do |job|
          {
            id: job.id,
            title: job.title,
            required_skills: job.job_required_skills.map(&:required_skill).join(", ")
          }
        end
      end

      private

      def job_repo
        Repositories::JobRepo.new
      end
    end
  end
end