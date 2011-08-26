module ActiveResource
  class Simulator
    
    
    def initialize(model)
      @model = model
      @@simulations = []
    end
    
    attr_reader :model, :simulations
    
    
    def simulate_request(method, path, body=nil, options={})
      @@simulations << prepare_simulation(method, path, body, options)
      load_simulations!
    end
    
    alias :simulate :simulate_request
    
    
    def create(body=nil, options={})
      path = options.delete(:path) || model.collection_path
      options.reverse_merge!({:status => 201})
      simulate_request(:post, path, body, options)
    end
      
    def show(param, body=nil, options={})
      path = options.delete(:path) || model.element_path(param)
      options.reverse_merge!({:status => 200})
      simulate_request(:get, path, body, options)
    end
      
    def update(param, options={})
      path = options.delete(:path) || model.element_path(param)
      options.reverse_merge!({:status => 204})
      simulate_request(:put, path, options[:body], options)
    end
      
    def destroy(param, options={})
      path = options.delete(:path) || model.element_path(param)
      options.reverse_merge!({:status => 200})
      simulate_request(:delete, path, options[:body], options)
    end
    
    
  private
    
    
    def prepare_simulation(method, path, body, options)
      # See the default values for HttpMock
      # http://api.rubyonrails.org/classes/ActiveResource/HttpMock.html
      [
        method,
        path,
        build_request_headers(method, path, options[:headers]),
        format_body(body),
        options[:status] || 200,
        options[:response_headers] || {}
      ]
    end
    
    def build_request_headers(method, path, headers)
      model.connection.send(:build_request_headers,
        (headers||{}),
        method,
        model.connection.site.merge(path))
    end
    
    def format_body(body)
      body && model.format.encode(body)
    end
    
    def load_simulations!
      ActiveResource::HttpMock.respond_to do |mock|
        @@simulations.each do |simulation|
          mock.send(*simulation)
        end
      end
    end
    
    
  end
end
