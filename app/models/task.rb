class Task < ApplicationRecord
  acts_as_paranoid
  acts_as_list scope: [:project_id]
  
  #relationship
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :tictacs

  belongs_to :project
  belongs_to :user
  #validates
  validates :title, presence: true
  enum status: {doing: 0 , done: 1 }

  #tag
  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(',')
  end

  def tag_items=(names)
    cur_tags = names.map do |item| 
      Tag.where(name: item.strip).first_or_create! unless item.blank?
    end.compact
    self.tags = cur_tags
  end

  def tag_items
    tags.map(&:name)
  end

end