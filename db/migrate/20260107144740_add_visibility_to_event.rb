class AddVisibilityToEvent < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :visibility, :integer
  end
end
