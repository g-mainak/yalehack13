class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
  	@projects = Project.all

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
  end
end

  def incHelpful
    unless params[:nonce] == session[:nonce][params[:id]]
      @project = Project.find(params[:id])
      @project.rating += 1
      @project.update_attributes(:rating)
      session[:nonce][params[:id]] = params[:nonce]
    end
    render :nothing
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  	@project = Project.find(params[:id])
    @comments = @project.comments
    @new = Comment.new
    @new.project_id = @project.id


  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
  end
end

  # GET /projects/new
  # GET /projects/new.json
  def new
  	@project = Project.new

  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
  end
end

  # GET /projects/1/edit
  def edit
  	@project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
  	@project = Project.new(params[:project])
    if (params[:photo])
      @project.photo = params[:photo].original_filename
      directory = Rails.root.join('app', 'assets', 'images')
      path = File.join(directory, @project.photo)
      File.open(path, 'wb') do |f|
        f.write(params[:photo].read)
      end
    else
      @project.photo = 'noimage.jpg'
    end


  	respond_to do |format|
      if @project.save
  			format.html { redirect_to @project, notice: 'project was successfully created.' }
  			format.json { render json: @project, status: :created, location: @project }
  		else
  			format.html { render action: "new" }
  			format.json { render json: @project.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
  	@project = Project.find(params[:id])

  	respond_to do |format|
  		if @project.update_attributes(params[:project])
  			format.html { redirect_to @project, notice: 'project was successfully updated.' }
  			format.json { head :no_content }
  		else
  			format.html { render action: "edit" }
  			format.json { render json: @project.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def comment
    @comment = Comment.new
    @comment.user = current_user
    @comment.project_id = params[:id].to_i
    @comment.text = params[:input]
    if @comment.save
      redirect_to project_path(params[:id].to_i)
    else
      redirect_to project_path(params[:id].to_i), :flash => { :error => "Comment can't be left blank."}
    end
  end


  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
  	@project = Project.find(params[:id])
  	@project.destroy

  	respond_to do |format|
  		format.html { redirect_to projects_url }
  		format.json { head :no_content }
  	end
  end

  def fbshare
    @oauth = Koala::Facebook::OAuth.new
    puts "==================="
    puts params
    fbid = User.find(session[:user_id]).uid # gets the user's ID 
    access_token = User.find(session[:user_id]).remember_token 
    # access_token = "AAACEdEose0cBAEfs7lt4YRCDKeUOjEEvLS6GDzofLEhFVUsgHGZBE6ERHvX9FtIrRUvRYEGhuSvDkUxffEPCAZAz1sLJjBLTDOwL7IVgZDZD"
    # initialize a Graph API connection, for instance 
    @graph = Koala::Facebook::API.new(access_token) 
    #Fetch user profile data 
    @graph.get_object("me")
    #Write into user's wall or friend feed 
    @graph.put_object("me", "feed", {:message => params[:message], :link => "http://yalestarter.herokuapp.com/"+project_path(:id => params[:id])}) 
    redirect_to project_path(:id => params[:id])
  end

  def promote
    Project.increment_counter(:rating, params[:id])
    flash[:success] = "Thanks for voting!"
    redirect_to :back
  end
end



