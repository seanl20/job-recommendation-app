module JobSeekers
  module Changesets
    class Create
      def self.map(tuple)
        tuple.select { |attr| JobSeekers::JobSeeker.attribute_names.include?(attr.to_s) }
      end
    end
  end
end