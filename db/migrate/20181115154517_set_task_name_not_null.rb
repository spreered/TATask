class SetTaskNameNotNull < ActiveRecord::Migration[5.2]
  def up
    change_table :tasks do |t|
      t.change :title, :string, null: false
    end
  end

  def down
    change_table :tasks do |t|
      t.change :title, :string
    end
  end
end
