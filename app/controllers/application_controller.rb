class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # deviseコントローラ上のアクションが動いた場合のみ befor actionのストロングパラメーターをうごかす。(deviseファイルに直接記述できないため)
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
