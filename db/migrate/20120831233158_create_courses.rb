class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.datetime :start_time
      t.date :start_date
      t.string :days_of_week
      t.string :title
      t.text :description

      t.timestamps
    end
    add_column :courses, :default_am, :boolean, :default => true
    add_column :courses, :active, :boolean ,:default => true
    add_index :courses, [:title, :days_of_week]
  end
end
