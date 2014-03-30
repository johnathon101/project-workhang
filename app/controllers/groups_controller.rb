class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  
  def create
    @group = Group.new(params[:group])
    @group.update_attributes({
      :mod => current_user.id
    })
    
    if @group.save
      Member.create({
        :group_id => @group.id,
        :user_id => current_user.id
      })
      redirect_to :groups
    else
      render "new"
    end
  end
  
  def new
    @group = Group.new
  end
  
  def delete_confirm
    @group = Group.find(params[:id])
  end
  
  def ban_confirm
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
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
    
    redirect_to :groups
  end
  
  def leave
    @group = Group.find(params[:id])
    
    Member.where(group_id: @group.id).where(user_id: current_user.id).update_all(group_id: nil, user_id: nil)
    
    redirect_to :groups
  end
  
  def join
    @group = Group.find(params[:id])
    
    Member.create({
      :group_id => @group.id,
      :user_id => current_user.id
    })
    
    if current_user.groups.count == 1
      redirect_to :root
    else
    redirect_to :groups
    end
  end
  
  def ban
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
  end
  
  def destroy
    @group = Group.find(params[:id])
    @member = Member.where(group_id: params[:id])
    
    # Try @group.destroy if the below doesn't work.
    @group.delete
    @member.delete_all
    
    redirect_to :groups
  end
end