class JobController < ApplicationController
  def index
    @jobs = Jobs::Queries::GetAll.new.call
  end

  def create
    Jobs::Command::CreateFromCsv.new.execute(params[:job])

    redirect_to(root_path, notice: "Jobs Created")
  rescue ActiveRecord::RecordNotUnique
    redirect_to(root_path, alert: "Jobs Id Existed")
  end
end
