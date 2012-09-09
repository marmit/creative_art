class AddDaysOfWeekColumnCourses < ActiveRecord::Migration
  def up
    add_column :courses, :day_of_week, :integer
  end

  def down
    remove_column :courses, :day_of_week
  end
end
