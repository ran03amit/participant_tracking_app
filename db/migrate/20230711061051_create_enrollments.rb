class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :registry, null: false, foreign_key: true
      t.references :coordinator, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.date :date_of_enrollment
      t.string :method_of_contact
      t.text :remarks

      t.timestamps
    end
  end
end
