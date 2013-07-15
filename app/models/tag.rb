class Tag < ActiveRecord::Base
  validates :name, presence: true,
                   length:     { maximum: 20 },
                   uniqueness: { case_sensitive: false }

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
end
