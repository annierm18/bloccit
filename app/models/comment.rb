class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
<<<<<<< HEAD

=======
>>>>>>> checkpoint-28-railscomments
end
