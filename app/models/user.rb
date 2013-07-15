class User < ActiveRecord::Base
  validates :name, presence: true,
                   length:     { maximum: 50 },
                   format:     { with: /\A[0-9a-z_]+\z/i },
                   uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }
  validates :email, presence:   true,
                    format:     { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  validates :api_token, length: { maximum: 40 },
                        uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :posts

  def create_post_with_metadata(params)
    post = posts.create(text: params[:text])

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
