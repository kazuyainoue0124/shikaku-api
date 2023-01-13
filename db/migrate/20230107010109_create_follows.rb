class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :send_follow_id
      t.integer :receive_follow_id

      t.timestamps
    end
    add_index :follows, :send_follow_id
    add_index :follows, :receive_follow_id
    add_index :follows, [:send_follow_id, :receive_follow_id], unique: true
  end
end
