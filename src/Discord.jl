module Discord

include("Discord/API.jl")
include("Discord/Client.jl")
include("Discord/Gateway.jl")

export
   Client,
   Settings

end
