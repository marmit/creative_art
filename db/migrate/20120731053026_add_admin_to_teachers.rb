class AddAdminToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :admin, :boolean, default: false
  end
end
