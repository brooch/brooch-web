class PostWithMetadata
  def initialize(params)
    @post     = params[:user].posts.build(text: params[:text])
    @taggings = []
    @tags     = []
    @author   = nil

    if params[:tags]
      params[:tags].each do |tag_name|
        if tag = Tag.find_by(name: tag_name)
          @taggings.push(@post.taggings.build(tag_id: tag.id))
        else
          @tags.push(@post.tags.build(name: tag_name))
        end
      end
    end

    if params[:author]
      @author = Author.find_or_initialize_by(name: params[:author])
    end
  end

  def self.create(args)
    post = new(args)
    post.save
    post
  end

  def save
    result = false

    if valid?
      @post.save
      @taggings.each { |t| t.save }
      @tags.each { |t| t.save }
      @author.save
      @post.author_id = @author.id
      result = true
    end

    result
  end

  def valid?
    post_valid     = @post.valid?
    taggings_valid = !@taggings.any? { |t| t.invalid? }
    tags_valid     = !@tags.any? { |t| t.invalid? }
    author_valid   = !@author || @author.valid?

    post_valid && taggings_valid && tags_valid && author_valid
  end

  def invalid?
    !valid?
  end

  def errors
    valid?

    errors = {}
    errors.merge!(@post.errors.as_json) unless @post.errors.empty?

    @tags.each do |t|
      # XXX: We don't handle multiple errors of tags
      unless t.errors.empty?
        errors[:tags] = t.errors[:name]
      end
    end

    if @author && !@author.errors.empty?
      errors[:author] = @author.errors[:name]
    end

    errors
  end

  def as_json(options = nil)
    hash = @post.as_json
    hash['tags']   = @tags.map { |t| t.as_json }
    hash['author'] = @author.as_json
    hash
  end
end