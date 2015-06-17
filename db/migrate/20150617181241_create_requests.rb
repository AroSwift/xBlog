class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :username
      t.string :password
      t.integer :user_id
      t.boolean :status, null: false, default: false

      t.timestamps null: false
    end
  end
end
