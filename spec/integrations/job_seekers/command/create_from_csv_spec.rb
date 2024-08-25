require "rails_helper"

RSpec.describe JobSeekers::Command::CreateFromCsv do
  describe "#execute" do
    subject(:execute) do
      described_class.new.execute(csv_data)
    end

    let(:job_seeker_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,name,skills\n")
      file.write("1,Alice Seeker,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Bob Applicant,\"JavaScript, HTML/CSS, React\"")
      file.flush
      file.rewind
      file
    end

    let!(:csv_data) { ActionDispatch::Http::UploadedFile.new(tempfile: job_seeker_upload, filename: "test.csv") }

    it "create job" do
      expect { execute }.to change { JobSeekers::JobSeeker.count }.by(2)
    end

    it "create job required skills" do
      expect { execute }.to change { JobSeekers::JobSeekerSkill.count }.by(6)
    end
  end
end
