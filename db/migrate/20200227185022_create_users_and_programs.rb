class CreateUsersAndPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
    add_index :users, :email, unique: true

    create_table :programs do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
    create_join_table :users, :programs do |t|
      t.index :program_id
      t.index :user_id

      t.boolean :active
    end

    add_index :programs_users, [:program_id, :user_id], name: :subscribe_index, unique: true
  end
end
