class AddIndexToTeachersUsername < ActiveRecord::Migration
  def change
    add_index :teachers, :username, unique: true
  end
end
