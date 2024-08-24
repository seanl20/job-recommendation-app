module Engine
  module Queries
    class JobMatching
      def match_jobs
        jobs = job_repo.jobs
        job_seekers = job_seeker_repo.job_seekers

        job_match_array = jobs.map do |job|
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

        job_match_array.flatten
      end

      def get_matching_skill_count(array_1, array_2)
        array_1.zip(array_2).count do |a, b| a==b end
      end

      def get_longest_array_count(array_1, array_2)
        [array_1, array_2].max.count
      end

      def get_matching_skill_percent_from_counts(count_1, count_2)
        ( count_1.to_f / count_2.to_f ) * 100
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