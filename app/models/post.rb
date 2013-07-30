class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }

  belongs_to :user
  belongs_to :author
  has_many   :taggings, dependent: :destroy
  has_many   :tags, through: :taggings
end
