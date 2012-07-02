class AddIndexToTeachersTeacherName < ActiveRecord::Migration
  def change
    add_index :teachers, :teacher_name, unique: true
  end
end
