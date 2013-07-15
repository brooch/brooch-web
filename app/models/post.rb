class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }

  belongs_to :user
  has_one    :author
  has_many   :taggings, dependent: :destroy
  has_many   :tags, through: :taggings
end
