class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :rows
      t.integer :columns
      t.timestamps
    end
  end
end
