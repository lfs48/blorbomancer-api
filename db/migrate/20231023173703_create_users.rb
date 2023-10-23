class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|

      t.string :username, null:false
      t.string :password_digest, null: false

      t.index :username, unique: true

      t.timestamps
    end
  end
end
