class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }
end
