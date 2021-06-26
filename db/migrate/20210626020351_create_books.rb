class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :content
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
