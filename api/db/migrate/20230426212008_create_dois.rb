class CreateDois < ActiveRecord::Migration[7.0]
  def change
    create_table :dois do |t|
      t.string :expression
      t.string :doi
      t.string :title
      t.string :snippet
      t.blob  :contents
      t.string :authors 
      t.timestamps
      t.index :doi
      t.index :expression
    end
  end
end
