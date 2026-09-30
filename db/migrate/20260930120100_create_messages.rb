class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :body, null: false
      t.datetime :read_at

      t.timestamps
    end

    add_index :messages, :read_at
  end
end
