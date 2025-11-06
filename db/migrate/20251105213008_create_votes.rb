class CreateVotes < ActiveRecord::Migration[8.1]
  def change
    create_table :votes do |t|
      t.boolean :vote, null: false
      t.references :user, null: false, foreign_key: true
      t.references :voteable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
