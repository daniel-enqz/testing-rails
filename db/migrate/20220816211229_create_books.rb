class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false, default: ''
      t.string :genre, null: false, default: ''
      t.references :author, foreign_key: true
      t.timestamps
    end
  end
end
