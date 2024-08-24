# frozen_string_literal: true

module JobSeekers
	class JobSeekerSkill < ApplicationRecord
    belongs_to :job_seeker
  end
end
