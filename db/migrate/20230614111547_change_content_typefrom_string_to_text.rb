class ChangeContentTypefromStringToText < ActiveRecord::Migration[7.0]
  def change
    change_column :blogs, :content, :text
  end
end
