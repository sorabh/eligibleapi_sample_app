class HomeController < ApplicationController
  layout 'application'

  before_filter :authorize  , only: 'index'

  def index
    @user=current_user
    @api_call = ApiCall.new

  end
end
