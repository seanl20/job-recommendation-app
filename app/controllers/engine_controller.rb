class EngineController < ApplicationController
  def index
    @job_match_array = Engine::Queries::JobMatching.new.call
  end
end
