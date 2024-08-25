# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /job_seekers", type: :request do
  subject(:send_request) { post job_seekers_path, params: {job_seeker: job_seeker_params} }

  context "when records doesn't exists" do
    let(:job_seeker_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,name,skills\n")
      file.write("1,Alice Seeker,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Bob Applicant,\"JavaScript, HTML/CSS, React\"")
      file.flush
      file.rewind
      file
    end

    let(:job_seeker_params) { Rack::Test::UploadedFile.new(job_seeker_upload) }

    it "creates job seeker" do
      expect { send_request }.to change { JobSeekers::JobSeeker.count }.by(2)
    end

    it "creates job seeker skills" do
      expect { send_request }.to change { JobSeekers::JobSeekerSkill.count }.by(6)
    end

    it "redirect to root" do
      send_request

      expect(response).to redirect_to root_path
    end
  end

  context "when records exists" do
    let!(:job_seeker) { FactoryBot.create(:job_seeker) }

    let(:job_seeker_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,name,skills\n")
      file.write("1,Alice Seeker,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Bob Applicant,\"JavaScript, HTML/CSS, React\"")
      file.flush
      file.rewind
      file
    end

    let(:job_seeker_params) { Rack::Test::UploadedFile.new(job_seeker_upload) }

    it "does not creates jobs" do
      expect { send_request }.to change { JobSeekers::JobSeeker.count }.by(0)
    end

    it "doex not creates job required skills" do
      expect { send_request }.to change { JobSeekers::JobSeekerSkill.count }.by(0)
    end

    it "redirect to root" do
      send_request

      expect(response).to redirect_to root_path
    end
  end
end
