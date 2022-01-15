"""mutable struct Client

Represents a Discord client.
Sends and receives data over a WebSocket connection.
"""
mutable struct Client
   config::Settings
   shards::Array{Shard}
end

mutable struct Shard
   id::UInt64
end
