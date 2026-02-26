class Comment < ApplicationRecord

  belongs_to :post
  validates :desc, presence: true
  validates :desc, length: {minimum: 10}

  after_create_commit -> { broadcast_prepend_to "posts", target: "comment_list" }
  after_destroy_commit -> { broadcast_remove_to "posts" }

end
