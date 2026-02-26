class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :title, length: {in: 3..20}
  validates :desc, presence: true
  validates :desc, length: {minimum: 10}

  after_update_commit -> { broadcast_prepend_to "update_post", target: "post" }

end
