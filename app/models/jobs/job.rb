# frozen_string_literal: true

module Jobs
	class Job < ApplicationRecord
		has_many :job_required_skills, class_name: "Jobs::JobRequiredSkill"
	end
end
