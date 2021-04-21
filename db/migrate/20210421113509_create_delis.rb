class CreateDelis < ActiveRecord::Migration[6.0]
  def change
    create_table :delis do |t|

      t.timestamps
    end
  end
end
