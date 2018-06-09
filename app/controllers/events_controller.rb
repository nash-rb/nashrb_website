class EventsController < ApplicationController
  public_permissions only: %i(index show)

  def index; end
end
