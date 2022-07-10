class Tag < ApplicationRecord
  has_many :book_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、post_tagsを通じて参照できる
  has_many :books,through: :book_tags

  validates :name, uniqueness: true, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end

end
