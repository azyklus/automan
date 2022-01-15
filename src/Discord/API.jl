"""mutable struct Settings

A data structure to hold configuration details for a Discord bot.
"""
mutable struct Settings
   shard_id::UInt64
   shard_count::UInt64
end
