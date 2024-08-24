# frozen_string_literal: true
require "csv"

module Jobs
  module Command
    class CreateFromCsv
      def execute(csv_data)
        CSV.foreach(csv_data, :headers => true) do |data|
          job_repo.create(data.to_hash)
        end
      end

      private

      def job_repo
        Repositories::JobRepo.new
      end
    end
  end
end