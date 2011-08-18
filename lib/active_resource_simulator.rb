require "active_resource"
require "active_resource/simulator"
require "active_resource_simulator/version"

module ActiveResourceSimulator
  
  def run_simulation
    yield ActiveResource::Simulator.new(self)
    ActiveResource::HttpMock.reset!
  end
  
end

ActiveResource::Base.extend(ActiveResourceSimulator)
