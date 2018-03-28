class ApplicationController < ActionController::API
  include ExceptionHandler
  include DeviseTokenAuth::Concerns::SetUserByToken
end
