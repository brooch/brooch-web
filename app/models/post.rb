class Post < ActiveRecord::Base
  validates :text, presence: true,
                   length:   { maximum: 255 }

  has_one  :author
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.create_with_metadata(params)
    post = create(text: params[:text])

    if params[:tags]
      params[:tags].each do |tag_name|
        if tag = Tag.find_by(name: tag_name)
          post.taggings.create(tag_id: tag.id)
        else
          post.tags.create(name: tag_name)
        end
      end
    end

    if params[:author]
      author = Author.find_or_create_by(name: params[:author])
      post.author_id = author.id
    end

    post
  end
end
