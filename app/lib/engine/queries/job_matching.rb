module Engine
  module Queries
    class JobMatching
      def call
        jobs = job_repo.jobs
        job_seekers = job_seeker_repo.job_seekers

        job_match_array = generate_job_match_array(jobs, job_seekers).flatten

        sort_array(job_match_array)
      end

      def generate_job_match_array(jobs, job_seekers)
        jobs.map do |job|
          required_skills_array = job.job_required_skills.map(&:required_skill)
          job_seekers.map do |job_seeker|
            job_seeker_skills_array = job_seeker.job_seeker_skills.map(&:skill)

            matching_skill_count = get_matching_skill_count(job_seeker_skills_array, required_skills_array)
            longest_array_count = get_longest_array_count(job_seeker_skills_array, required_skills_array)
            matching_skill_percent = get_matching_skill_percent_from_counts(matching_skill_count, longest_array_count)

            {
              jobseeker_id: job_seeker.id,
              jobseeker_name: job_seeker.name,
              job_id: job.id,
              job_title: job.title,
              matching_skill_count:,
              matching_skill_percent:
            }
          end
        end
      end

      def sort_array(job_match_array)
        job_match_array.sort_by { |array| [array[:jobseeker_id], -array[:matching_skill_percent], array[:job_id]] }
      end

      def get_matching_skill_count(job_seeker_skills_array, required_skills_array)
        job_seeker_skills_array.zip(required_skills_array).count { |a, b| a == b }
      end

      def get_longest_array_count(job_seeker_skills_array, required_skills_array)
        [job_seeker_skills_array, required_skills_array].max.count
      end

      def get_matching_skill_percent_from_counts(matching_skill_count, longest_array_count)
        ((matching_skill_count.to_f / longest_array_count.to_f) * 100).to_i
      end

      private

      def job_repo
        Repositories::JobRepo.new
      end

      def job_seeker_repo
        Repositories::JobSeekerRepo.new
      end
    end
  end
end
