class CreateDeliTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :deli_tag_relations do |t|
      t.references :deli, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
