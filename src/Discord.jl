module Discord

include("Discord/API.jl")
include("Discord/Client.jl")
include("Discord/Gateway.jl")
include("Discord/REST.jl")

export
   Client,
   Settings

end
