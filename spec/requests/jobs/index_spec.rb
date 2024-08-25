# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /job", type: :request do
  it "returns a successful response" do
    get job_index_path

    expect(response).to be_successful
  end
end
