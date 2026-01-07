class ChangeVisibility < ActiveRecord::Migration[8.1]
  def change
    change_column_default :events, :visibility, 0
    change_column_null :events, :visibility, false
  end
end
