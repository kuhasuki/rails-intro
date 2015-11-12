class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :count, null: false
      t.integer :visitor_id, null: false
      t.integer :url_id, null: false
      t.timestamps null: false
    end
    add_index(:visits, :visitor_id)
    add_index(:visits, :url_id)
  end
end
