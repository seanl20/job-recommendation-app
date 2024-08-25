require "rails_helper"

RSpec.describe Engine::Queries::JobMatching do
  describe "#call" do
    subject(:call) do
      described_class.new.call
    end

    context "when records exists" do
      let!(:job_seeker) { FactoryBot.create(:job_seeker) }
      let!(:job_seeker_skill_1) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Test") }
      let!(:job_seeker_skill_2) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Rspec") }
      let!(:job) { FactoryBot.create(:job) }
      let!(:job_required_skill_1) { FactoryBot.create(:job_required_skill, job:, required_skill: "Test") }
      let!(:job_required_skill_2) { FactoryBot.create(:job_required_skill, job:, required_skill: "Rspec") }
  
      it "return records" do
        expect(call).to match_unordered_elements( {
          jobseeker_id: job_seeker.id,
          jobseeker_name: job_seeker.name, 
          job_id: job.id, 
          job_title: job.title, 
          matching_skill_count: 2, 
          matching_skill_percent: 100 
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