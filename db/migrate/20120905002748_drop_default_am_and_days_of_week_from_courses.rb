class DropDefaultAmAndDaysOfWeekFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :default_am
    remove_column :courses, :days_of_week
  end

  def down
    add_column :courses, :default_am
    add_column :courses, :days_of_week
  end
end
