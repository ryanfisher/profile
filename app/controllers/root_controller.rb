class RootController < ApplicationController
  caches_action :index, expires_in: 15.minutes

  def index; end
end
