class Api::UsersController < ApiController
  before_action :password_check

  def new
    user = User.new(creat_user_params)
    debugger
    if user.save
      render json:{status: :ok}, status: :ok
    else
      render json:{status: :failed}, status: :bad_request
    end
  end

  def find_user
    user = User.find_by_email find_user_params
    if user
      render json: user, status: :ok
    else
      render json: {msg:'user not found'}, status: :ok
    end
  end

  private

  def password_check
    if params[:confirm_password] != params[:password]
      render json: {msg: 'confirm_passwrd inconsistent'}, status: :bad_request
    end
  end

  def creat_user_params
    params.permit(:name, :email, :password)
  end

  def find_user_params
    params.permit(:email)
  end

end