class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :summary, null: false

      # The three parts of a case study
      t.text :problem
      t.text :approach
      t.text :outcome

      t.string :role
      t.string :tech_stack
      t.string :repo_url
      t.string :live_url
      t.integer :year

      t.boolean :featured, null: false, default: false
      t.boolean :published, null: false, default: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    add_index :projects, %i[published position]
  end
end
