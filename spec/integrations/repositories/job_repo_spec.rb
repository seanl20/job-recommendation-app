require "rails_helper"

RSpec.describe Repositories::JobRepo do
  describe "#create" do
    subject(:create) do
      described_class.new.create(attrs)
    end

    let!(:attrs) do
      {
        "id" => 1, 
        "title" => "John", 
        "required_skills" => "Test, Rspec, Running"
      }
    end

    it "create job" do
      expect { create }.to change {Jobs::Job.count}.by(1)
    end

    it "create job required skills" do
      expect { create }.to change {Jobs::JobRequiredSkill.count}.by(3)
    end
  end

  describe "#jobs" do
    subject(:jobs) do
      described_class.new.jobs
    end

    context "when records exists" do
      let!(:job) { FactoryBot.create(:job) }
      let!(:job_required_skill_1) { FactoryBot.create(:job_required_skill, job:, required_skill: "Test") }
      let!(:job_required_skill_2) { FactoryBot.create(:job_required_skill, job:, required_skill: "Rspec") }
  
      it "return records" do
        expect(jobs).to match_unordered_elements(job)
        expect(jobs.first.job_required_skills).to match_unordered_elements(job_required_skill_1, job_required_skill_2)
      end
    end

    context "when records does not exists" do
      it "returns empty" do
        expect(jobs).to be_empty
      end
    end
  end
end