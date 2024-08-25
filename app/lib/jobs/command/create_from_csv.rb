# frozen_string_literal: true

require "csv"

module Jobs
  module Command
    class CreateFromCsv
      def execute(csv_data)
        csv = CSV.open(csv_data, headers: true)
        csv.lazy.each_slice(Types::BATCH_SIZE) do |csv_rows|
          job_repo.batch_create(csv_rows.map(&:to_hash))
        end
      end

      private

      def job_repo
        Repositories::JobRepo.new
      end
    end
  end
end
