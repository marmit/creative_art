class AddRememberTokenToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :remember_token, :string
    add_index  :teachers, :remember_token
  end
end
