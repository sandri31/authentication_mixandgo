class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { in: 10..5000 }
end
