class FeedsController < ApplicationController
  session :off
  layout  nil
  
  def show
    @feed = Feed.find(:first, :order => 'random()')
  end
end
