require 'tenjin'

module MeshU  
  class Application
    def initialize
      @template = Tenjin::Engine.new(:postfix => '.rhtml', :path => 'app/views', :layout => 'layout.rhtml')
    end
    
    def call(env)
      _, controller, action = env["PATH_INFO"].split("/")
      Object.const_get("#{(controller || 'home').capitalize}Controller").new(@template, env).call(action || 'index')
    end
  end
  
  class Controller
    def initialize(template, env)
      @status   = 200
      @headers  = { 'Content-Type' => 'text/html' }
      @body     = nil
      @template = template
      @request  = Rack::Request.new(env)
    end

    def call(action)
      send(action)
      render(action) unless @body
      [@status, @headers, @body]
    end
    
    def render(action)
      @body = @template.render(:"#{self.class.name.gsub("Controller", "").downcase}/#{action}", instance_variables.inject({}) {|h,v| h[v[1..-1]] = instance_variable_get(v); h})
    end
  end
end

require 'app/controllers'

use Rack::CommonLogger
use Rack::Reloader, 1
use Rack::ShowExceptions

run Rack::Cascade.new([
  Rack::File.new("public"),
  MeshU::Application.new
])
