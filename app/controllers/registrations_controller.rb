class RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      allow = [:email, :password, :password_confirmation, :username, :fullname]
      params.require(resource_name).permit(allow)
    end

    def account_update_params
	    allow = [:email, :password, :password_confirmation, 
	    	:current_password, :username, :fullname, :avatar]
      params.require(resource_name).permit(allow)
	  end

end