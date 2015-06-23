class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :username
      t.string :password
      t.integer :user_id
      t.boolean :status, null: false, default: false
      t.string :accepted_by
      t.string :rejected_by

      t.timestamps null: false
    end
  end
end
