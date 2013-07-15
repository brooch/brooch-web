class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.create_with_metadata(params)
    post = create(text: params[:text])

    if params[:tag]
      if tag = Tag.find_by(name: params[:tag])
        post.taggings.create(tag_id: tag.id)
      else
        post.tags.create(name: params[:tag])
      end
    end

    post
  end
end
