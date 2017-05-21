class Api::SessionsController < ApiController

  def login
    user = User.find_by(email: loginParam[:email].downcase)
    if user && user.authenticate(params[:password])
      gon.user = {name:user.name, email:user.email}
      log_in user
      render json: {status: :ok, msg: 'log in successful'}, status: :ok
    else
      render json: {status: :failed, msg: 'log in failed'}, status: :unauthorized
    end
  end

  def destroy

  end

  private
  def loginParam
    params.require(:email).permit :password
  end
end