class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :email, :signature, :password])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
        # devise_parameter_sanitizer.permit(:account_update, keys: [:username, :fullname, :email, :password, :password_confirmation, :role_id])
    end
end
