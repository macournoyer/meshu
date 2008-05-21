class MemCache
  def initialize
    @store = {}
  end
  
  def call(env)
    key = env["PATH_INFO"]
    
    case env["REQUEST_METHOD"]
    when "GET"
      [200, {}, @store[key]]
    when "POST", "PUT"
      @store[key] = env["rack.input"].read
      [200, {}, ""]
    else
      [500, {}, "Unsupported method"]
    end
  end
end

run MemCache.new