# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /job", type: :request do
  subject(:send_request) { post job_index_path, params: { job: job_params } }

  context "when records doesn't exists" do
    let(:job_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,title,required_skills\n")
      file.write("1,Ruby Developer,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Frontend Developer,\"JavaScript, HTML/CSS, React, Teamwork\"")
      file.flush
      file.rewind
      file
    end

    let(:job_params) { Rack::Test::UploadedFile.new(job_upload) }

    it "creates jobs" do
      expect { send_request }.to change {Jobs::Job.count}.by(2)
    end

    it "creates job required skills" do
      expect { send_request }.to change {Jobs::JobRequiredSkill.count}.by(7)
    end

    it "redirect to root" do
      send_request

      expect(response).to redirect_to root_path
    end
  end

  context "when records exists" do
    let!(:job) { FactoryBot.create(:job) }

    let(:job_upload) do
      file = Tempfile.new("test.csv")
      file.write("id,title,required_skills\n")
      file.write("1,Ruby Developer,\"Ruby, SQL, Problem Solving\"\n")
      file.write("2,Frontend Developer,\"JavaScript, HTML/CSS, React, Teamwork\"")
      file.flush
      file.rewind
      file
    end

    let(:job_params) { Rack::Test::UploadedFile.new(job_upload) }

    it "does not creates jobs" do
      expect { send_request }.to change {Jobs::Job.count}.by(0)
    end

    it "doex not creates job required skills" do
      expect { send_request }.to change {Jobs::JobRequiredSkill.count}.by(0)
    end

    it "redirect to root" do
      send_request

      expect(response).to redirect_to root_path
    end
  end
end
