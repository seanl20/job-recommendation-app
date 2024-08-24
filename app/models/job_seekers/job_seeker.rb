# frozen_string_literal: true

module JobSeekers
	class JobSeeker < ApplicationRecord
    has_many :job_seeker_skills
  end
end
