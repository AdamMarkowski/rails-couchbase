class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.references :post, foreign_key: true
      t.string :ip_addr

      t.timestamps
    end
  end
end
