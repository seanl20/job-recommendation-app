require "rails_helper"

RSpec.describe Jobs::Queries::GetAll do
  describe "#call" do
    subject(:call) do
      described_class.new.call
    end

    context "when records exists" do
      let!(:job) { FactoryBot.create(:job) }
      let!(:job_required_skill_1) { FactoryBot.create(:job_required_skill, job:, required_skill: "Test") }
      let!(:job_required_skill_2) { FactoryBot.create(:job_required_skill, job:, required_skill: "Rspec") }

      it "return records" do
        expect(call).to match_unordered_elements({
          id: job.id,
          title: job.title,
          required_skills: "Test, Rspec"
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
