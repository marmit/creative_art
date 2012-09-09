class ChangeCoursesStartTimeToString < ActiveRecord::Migration
  def up
    remove_column :courses, :start_time
    add_column :courses, :start_time, :string
  end

  def down
    remove_column :courses, :start_time, :string
    add_column :courses, :start_time, :datetime
  end
end
