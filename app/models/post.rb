class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
