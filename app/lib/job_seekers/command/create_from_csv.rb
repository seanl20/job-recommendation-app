# frozen_string_literal: true
require "csv"

module JobSeekers
  module Command
    class CreateFromCsv
      def execute(csv_data)
        CSV.foreach(csv_data, :headers => true) do |data|
          job_seeker_repo.create(data.to_hash)
        end
      end

      private

      def job_seeker_repo
        Repositories::JobSeekerRepo.new
      end
    end
  end
end