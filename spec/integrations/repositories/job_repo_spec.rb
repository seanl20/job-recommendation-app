require "rails_helper"

RSpec.describe Repositories::JobRepo do
  describe "#batch_create" do
    subject(:batch_create) do
      described_class.new.batch_create(attrs)
    end

    let!(:attrs) do
      [
        {
          "id" => 1, 
          "title" => "John", 
          "required_skills" => "Test, Rspec, Running"
        },{
          "id" => 2, 
          "title" => "John", 
          "required_skills" => "Test, Rspec, Running"
        },{
          "id" => 3, 
          "title" => "John", 
          "required_skills" => "Test, Rspec, Running"
        }
      ]
    end

    it "create job" do
      expect { batch_create }.to change {Jobs::Job.count}.by(3)
    end

    it "create job required skills" do
      expect { batch_create }.to change {Jobs::JobRequiredSkill.count}.by(9)
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