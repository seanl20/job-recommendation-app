require "rails_helper"

RSpec.describe Repositories::JobSeekerRepo do
  describe "#create" do
    subject(:create) do
      described_class.new.create(attrs)
    end

    let!(:attrs) do
      {
        id: 1, name: "John", skills: "Test, Rspec, Running"
      }
    end

    it "create job seeker" do
      expect { create }.to change {JobSeekers::JobSeeker.count}.by(1)
    end

    it "create job seeker skills" do
      expect { create }.to change {JobSeekers::JobSeekerSkill.count}.by(3)
    end
  end

  describe "#job_seekers" do
    subject(:job_seekers) do
      described_class.new.job_seekers
    end

    context "when records exists" do
      let!(:job_seeker) { FactoryBot.create(:job_seeker) }
      let!(:job_seeker_skill_1) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Test") }
      let!(:job_seeker_skill_2) { FactoryBot.create(:job_seeker_skill, job_seeker:, skill: "Rspec") }
  
      it "return records" do
        expect(job_seekers).to match_unordered_elements(job_seeker)
        expect(job_seekers.first.job_seeker_skills).to match_unordered_elements(job_seeker_skill_1, job_seeker_skill_2)
      end
    end

    context "when records does not exists" do
      it "returns empty" do
        expect(job_seekers).to be_empty
      end
    end
  end
end