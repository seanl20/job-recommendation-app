# frozen_string_literal: true

module Jobs
  class JobRequiredSkill < ApplicationRecord
    belongs_to :job, class_name: "Jobs::Job"
  end
end
