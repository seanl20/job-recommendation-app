require "rails_helper"

RSpec.describe JobSeekers::Queries::GetAll do
  describe "#call" do
    subject(:call) do
      described_class.new.call
    end

    context "when records exists" do
      let!(:job_seeker) { FactoryBot.create(:job_seeker) }
      let!(:job_seeker_skill_1) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Test") }
      let!(:job_seeker_skill_2) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Rspec") }

      it "return records" do
        expect(call).to match_unordered_elements({
          id: job_seeker.id,
          name: job_seeker.name,
          skills: "Test, Rspec"
        })
      end
    end

    context "when records does not exists" do
      it "returns empty" do
        expect(call).to be_empty
      end
    end
  end
end
