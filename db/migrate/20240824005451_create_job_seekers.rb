class CreateJobSeekers < ActiveRecord::Migration[7.2]
  def change
    create_table :job_seekers do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
