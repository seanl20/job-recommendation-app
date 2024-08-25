class JobSeekersController < ApplicationController
  def index
    @job_seekers = JobSeekers::Queries::GetAll.new.call
  end

  def create
    JobSeekers::Command::CreateFromCsv.new.execute(params[:job_seeker])

    redirect_to(root_path, notice: "Job Seekers Created")
  rescue ActiveRecord::RecordNotUnique
    redirect_to(root_path, alert: "Job Seekers Id Existed")
  end
end
