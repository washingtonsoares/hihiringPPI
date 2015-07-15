class Admin::PublicationsController < Admin::AdminController
 # before_action :set_publication, only: [:show, :edit, :update, :destroy]

  def index
    @admin_publications = Admin::Publication.search(params[:search]).paginate( :per_page => 10 , :page => params[:page])
  end

  def my_publications
    @user = User.find(params[:user_id])
    @owner_publications = Admin::Publication.find_by(params[current_user.id])
  end

  def show
    @publication = Admin::Publication.find(params[:id])
    @rate = Ratings.where(admin_publications_id: @publication.id)
  end

  def new
   #@publication = Publication.new
   #respond_with(@publication)
  end

  def rating
    @rate = Ratings.new
    @rate.admin_publications_id = params[:publication_id].to_i
    @rate.users_id = params[:user_id].to_i
    @rate.nota = params[:nota].to_i
    if @rate.save
      logger.debug 'Sucesso'
    end
    render :nothing => true, :status => 200
  end

  def edit
    @publication = Admin::Publication.find(params[:id])
    render "admin/users/publications/_edit.html.erb"
  end

  def download
    @publication = Admin::Publication.find(params[:publication_id])
    logger.debug "veio aqui"
    logger.debug "arquivo que eu preciso baixar #{@publication.archive_url}"
    #send_file (@publication.archive.url, disposition: 'attachment')
    redirect_to @publication.archive_url
  end

  def create
    @publication = Admin::Publication.new(publication_params)
    @user        = User.find(@publication.user_id)
    @publication.author = @user.name

    if @publication.save
      render template: "/admin/users/publications/create.js.erb"
    else
      logger.debug "não foi"
    end
  end

  def update
    @admin_publication = Admin::Publication.find(params[:id])
    @admin_publication.update(params[:publication].permit(:title, :resume,:thumb,:video,:archive))
  end

  def destroy
    @admin_publication.destroy
  end

  private
    def publication_params
      params.require(:admin_publication).permit(:title, :resume, :user_id,:thumb,:video,:archive)
    end
end
