class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.string :author
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
