module JobSeekers
  module Changesets
    class Create
      def self.map(tuple)
        tuple.select { |attr| Jobs::Job.attribute_names.include?(attr.to_s) }
      end
    end
  end
end