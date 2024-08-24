class CreateJobRequiredSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :job_required_skills do |t|
      t.string :required_skill
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
