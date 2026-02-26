class AddPostIdToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :post_id, :integer
  end
end
