module Discord

include("Discord/API.jl")
include("Discord/Client.jl")
include("Discord/Gateway.jl")
include("Discord/REST.jl")


mutable struct Shard
   id::UInt64
end


"""mutable struct Client

Represents a Discord client.
Sends and receives data over a WebSocket connection.
"""
mutable struct Client
   config::Settings
   shards::Array{Shard}
end

function Client(settings::Settings)
   client = Client(settings, [Shard(0)])
   for i = 0:client.shard_count
      shard = Shard(i)
      push!(client.shards, shard)
   end

   return client
end


export
   Client,
   Shard,
   Settings

end
