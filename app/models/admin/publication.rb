class Admin::Publication < ActiveRecord::Base

  def to_param
    "#{id} #{title}".parameterize 
  end

  belongs_to :user
  has_many :admin_comments, :class_name => 'Admin::Comment'
  mount_uploader :thumb, AvatarUploader
  mount_uploader :archive, ArquiveUploader

  def self.search(search)
    if search
      self.where("title LIKE :search OR author LIKE :search OR resume LIKE :search ",:search => "%#{search}%")
    else
      all
    end
  end


end