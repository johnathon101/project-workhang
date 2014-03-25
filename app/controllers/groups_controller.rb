class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @groups.each do |group|
      @members = User.where("#{group.id} = ?", group)
      @members.each do |member|
        @email = member.email
        @avatar = Gravatar.new("#{@email}").image_url + "?s=75"
      end
    end
  end
  
  def create
    @group = Group.new(params[:group])
    
    if @group.save
      redirect_to(group_path(@group.id))
    else
      render "new"
    end
  end
  
  def new
    @group = Group.new
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    @group.update_attributes(params[:group])
    
    redirect_to(group_path(@group.id))
  end
  
  def destroy
    @group = Group.find(params[:id])
    
    # Try @group.destroy if the below doesn't work.
    @group.delete
    
    redirect_to :groups
  end
end