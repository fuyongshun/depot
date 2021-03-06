class Product < ActiveRecord::Base
  
  default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :comments, :dependent => :destroy
  has_many :stars, :dependent => :destroy
  
  before_destroy :ensure_not_referenced_by_any_line_item
 
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}    
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with  => %r{\.(gif|png|jpg)$}i,
    :message => 'must be a URL for gif, jpg or png image.'
  }
    
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors[:base] << "line item present"
    end
  end
  
  #search------------
  def self.search(query)
    if query 
      find(:all, :conditions => ['title LIKE ?', "%#{query}%"]) 
    else 
      find(:all) 
    end 
    #Product.all
  end
  #-------------------
 
  #upload image-----------
  def upload_image= (file_field)
    now = Time.now
    @user_folder = "product_images/"
    @file_name = now.strftime("%y%m%d%H%M%S") + '_' + file_field.original_filename

    self.image_url = @user_folder + @file_name

    if !file_field.original_filename.empty? and file_field.content_type.chomp =~ /gif|jpeg|png/
      File.open("public/images/" + @user_folder + @file_name,"wb+") do |f|
        f.write(file_field.read)
      end
    end
  end
  #------------------------------
 
  #---------grade-----------
  def average_grade
    sum_grades = stars.to_a.sum { |star| star.grade }
    sum_grades/stars.size
  end
  #-------------------------
 
end
