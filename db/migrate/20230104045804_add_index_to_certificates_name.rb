class AddIndexToCertificatesName < ActiveRecord::Migration[7.0]
  def change
    add_index :certificates, :name, unique: true
  end
end
