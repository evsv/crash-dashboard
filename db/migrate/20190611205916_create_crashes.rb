class CreateCrashes < ActiveRecord::Migration[5.1]
  def change
    create_table :crashes do |t|
      t.datetime :crash_date
      t.integer :crash_day_of_week
      t.integer :crash_hour
      t.integer :crash_month
      t.string :crash_type
      t.integer :injuries_fatal
      t.integer :injuries_incapacitating
      t.integer :injuries_no_indication
      t.integer :injuries_non_incapacitating
      t.string :lighting_condition
      t.string :prim_contributory_cause
      t.string :rd_no

      t.timestamps
    end
  end
end
