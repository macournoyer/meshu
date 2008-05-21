class HomeController < MeshU::Controller
  def index
    @title = 'Welcome to MeshU!'
    @say = @request.params['say']
  end
  
  def cool
    @say = "Cool!"
    render :adsf
  end
end
