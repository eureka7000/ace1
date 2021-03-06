class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def updateName
    name = params[:name]
    @group = Group.find(params[:id])
    @group.name = name
    @group.save

    ret = { ret: "success" }
    respond_to do |format|
      format.json { render json: ret }
    end
  end

  def get_groups
    leader_id = params[:leader_id]
    @groups = Group.where(:user_id => leader_id)

    unless @groups.blank?
      ret = []
      @groups.each do |group|
        ret << {
            id: group.id,
            name: group.name
        }
      end
    end

    respond_to do |format|
      format.json { render :json => ret }
    end
  end

  def save_users
    group_id = params[:group_id]
    groups_users = params[:groups_users]

    @tmp_groups_users = GroupsUser.where('group_id = ?', group_id)
    @tmp_groups_users.delete_all

    unless groups_users.blank?
      groups_users.each do |groups_users|
        groupsUser = GroupsUser.new
        groupsUser.group_id = group_id
        groupsUser.user_id = groups_users
        groupsUser.save
      end
    end

    respond_to do |format|
      format.html { redirect_to '/groups/'+ group_id }
    end
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @user_relations = UserRelation.where('related_user_id = ?', current_user.id)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to '/mypages/student_management', notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    ret = { ret: "success" }
    respond_to do |format|
      # format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      # format.json { head :no_content }
      format.json { render json: ret }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:user_id, :name)
    end
end
