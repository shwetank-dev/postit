class Post < ApplicationRecord
  POSTS_PER_PAGE = 3

  default_scope {
    order('created_at DESC')
  }

  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true

  before_save :generate_slug

  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end