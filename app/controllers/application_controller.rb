class ApplicationController < ActionController::Base
  layout "application"
  include Pagy::Backend
end
