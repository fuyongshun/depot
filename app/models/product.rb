class Product < ActiveRecord::Base
  
  default_scope :order => 'title'
  
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}    
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with  => %r{\.(gif|png|jpg)$}i,
    :message => 'must be a URL for gif, jpg or png image.'
  }
end
