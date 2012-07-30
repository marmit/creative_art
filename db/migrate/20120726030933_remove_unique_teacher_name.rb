class RemoveUniqueTeacherName < ActiveRecord::Migration
  def up
    remove_index :teachers, :teacher_name
    add_index :teachers, :teacher_name
  end

  def down
    remove_index :teachers, :teacher_name
    add_index :teachers, :teacher_name, unique: true
  end
end
