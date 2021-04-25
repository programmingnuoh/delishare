class CreateDelis < ActiveRecord::Migration[6.0]
  def change
    create_table :delis do |t|

      t.string :name, null:false
      t.text :text, null:false
      t.integer :supermarket_id, null:false
      t.references :user, null:false, foreign_key: true
      t.references :category, null:false, foreign_key: true
      t.timestamps
    end
  end
end
