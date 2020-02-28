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
    create_table :programs_users do |t|
      t.bigint :program_id
      t.bigint :user_id

      t.boolean :active, default: :true
    end
    add_index :programs_users, :program_id
    add_index :programs_users, :user_id
    add_index :programs_users, [:program_id, :user_id], name: :subscribe_index, unique: true
  end
end
