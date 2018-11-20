class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, default: 'normal'
    User.update_all( role: 'normal' )
  end
end
