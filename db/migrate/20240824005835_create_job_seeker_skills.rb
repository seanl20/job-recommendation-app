class CreateJobSeekerSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :job_seeker_skills do |t|
      t.string :skill
      t.references :job_seeker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
