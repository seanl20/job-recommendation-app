# frozen_string_literal: true
require "csv"

module JobSeekers
  module Command
    class CreateFromCsv
      def execute(csv_data)
        csv = CSV.open(csv_data, headers: true)
        csv.lazy.each_slice(Types::BATCH_SIZE) do |csv_rows|
          job_seeker_repo.batch_create(csv_rows.map(&:to_hash))
        end
      end

      private

      def job_seeker_repo
        Repositories::JobSeekerRepo.new
      end
    end
  end
end