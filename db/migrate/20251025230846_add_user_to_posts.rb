class AddUserToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :user, null: false, foreign_key: true, index: true
  end
end
