class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :certificate, null: false, foreign_key: true
      t.string :title
      t.integer :study_period
      t.text :how_to_study
      t.integer :valuable_score
      t.text :who_is_recommended

      t.timestamps
    end
    add_index :posts, [:user_id, :certificate_id, :created_at]
  end
end
