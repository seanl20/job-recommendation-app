# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /job_seekers", type: :request do
  it "returns a successful response" do
    get job_seekers_path

    expect(response).to be_successful
  end
end
