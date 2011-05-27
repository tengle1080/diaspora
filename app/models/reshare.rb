class Reshare < Post 
  belongs_to :root, :class_name => 'Post'
  belongs_to :ancestor, :class_name => 'Post'
  validate :root_must_be_public, :author_cant_reshare_themselves, :root_is_not_share
  attr_accessible :root, :root_id, :public
  validates_presence_of :root_id

  before_validation do 
    self.public = true
  end

  private

  def root_must_be_public
    if !self.root_id? || !self.root.public
      errors[:base] << "you must reshare public posts"
      return false
    end
  end

  def root_is_not_share
    if !self.root_id? || !self.root.is_a?(Reshare)
      errors[:base] << "you must reshare public posts"
      return false
    end
  end

  def author_cant_reshare_themselves
    return true if self.root_id.blank? 
    if (self.author == self.root.author)
      errors[:base] << "cannot reshare your own post"
      return false
    end
  end
end
