class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :generation
      t.jsonb :matrix
      t.timestamps
    end
  end
end
