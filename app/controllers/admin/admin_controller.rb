class Admin::AdminController < ApplicationController

  before_filter :authenticate_user!
  layout 'admin/application'
  
  helper :'admin/publications'
  helper :'admin/comments'

end