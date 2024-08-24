require "rails_helper"

RSpec.describe Jobs::Command::CreateFromCsv do
  describe "#execute" do
    subject(:execute) do
      described_class.new.execute(csv_data)
    end

    let(:job_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,title,required_skills\n")
      file.write("1,Ruby Developer,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Frontend Developer,\"JavaScript, HTML/CSS, React, Teamwork\"")
      file.flush
      file.rewind
      file
    end

    let!(:csv_data) { ActionDispatch::Http::UploadedFile.new(tempfile: job_upload, filename: "test.csv") }

    it "create job" do
      expect { execute }.to change {Jobs::Job.count}.by(2)
    end

    it "create job required skills" do
      expect { execute }.to change {Jobs::JobRequiredSkill.count}.by(7)
    end
  end
end