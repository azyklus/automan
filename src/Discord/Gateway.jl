"""const DISCORD_GATEWAY

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway)
"""
const DISCORD_GATEWAY = "wss://gateway.discord.gg/?v=9"

const Snowflake = Int64

"""struct UserObject

Represents a user in Discord.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/user)
"""
struct UserObject
   id::Snowflake
   username::String
   discriminator::String
   avatar::String
   bot::Bool
   system::Bool
   mfa_enabled::Bool
   banner::String
   accent_color::Int64
   locale::String
   verified::String
   email::String
   flags::Int64
   premium_type::Int64
   public_flags::Int64
end

"""struct TeamMemberObject

Represents a member of a team in Discord.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/teams#data-models-team-object)
"""
struct TeamMemberObject
   membership_state::Int64
   permissions::Array{String}
   team_id::Snowflake
   user::UserObject
end

"""struct TeamObject

Represents a \"team\" in Discord.


## Resources

- [Discord API docs](https://discord.com/developers/docs/topics/teams#data-models-team-object)
"""
struct TeamObject
   icon::String
   id::Snowflake
   members::Array{TeamMemberObject}
   name::String
   owner_user_id::Snowflake
end


"""@enum ApplicationFlags

An enum that represents possible flags supplied
to an application resource.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/application)
"""
@enum ApplicationFlags begin
   GATEWAY_PRESENCE = 1 << 12
   GATEWAY_PRESENCE_LIMITED = 1 << 13
   GATEWAY_GUILD_MEMBERS = 1 << 14
   GATEWAY_GUILD_MEMBERS_LIMITED = 1 << 15
   VERIFICATION_PENDING_GUILD_LIMIT = 1 << 16
   EMBEDDED = 1 << 17
   GATEWAY_MESSAGE_CONTENT = 1 << 18
   GATEWAY_MESSAGE_CONTENT_LIMITED = 1 << 19
end


"""struct ApplicationObject

Represents an application resource in Discord.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/application)
"""
struct ApplicationObject
   id::Snowflake
   name::String
   icon::String
   description::String
   rpc_origins::Array{String}
   bot_public::Bool
   terms_of_service_url::String
   privacy_policy_url::String
   owner::UserObject
   summary::String
   verify_key::String
   team::TeamObject
   guild_id::Snowflake
   primary_sku_id::Snowflake
   slug::String
   cover_image::String
   flags::Int64
end


"""struct ConnectionProperties

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#identify-identify-connection-properties)
"""
struct ConnectionProperties
   os::String
   browser::String
   device::String
end

"""struct IdentifyRequest

Used to initiate a handshake with the Discord gateway.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#identify-identify-structure)
"""
struct GatewayIdentify
   token::String
   properties::ConnectionProperties
   large_threshold::UInt64
   shard::Array{UInt64}
   presence::UpdatePresenceObject
   intents::UInt64
end

"""struct GatewayResume

Used to resume a disrupted connection to the gateway.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#resume-resume-structure)
"""
struct GatewayResume
   token::String
   session_id::String
   seq::Int64
end


"""struct Heartbeat

Used to maintain an active gateway connection.
The interval at which heartbeats are to be sent is received as part of
the initial handshake.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#heartbeat)
"""
struct Heartbeat
   op::Int64
   d::Int64
end


"""struct GuildMembersRequest

Used to request all members for a guild or a list of guilds. When initially connecting,
if you don't have the `GUILD_PRESENCES` Gateway Intent, or if the guild is over 75k members,
it will only send members who are in voice, plus the member for you (the connecting user).
Otherwise, if a guild has over `large_threshold` members (value in the Gateway Identify),
it will only send members who are online, have a role, have a nickname, or are in a voice channel,
and if it has under large_threshold members, it will send all members.

If a client wishes to receive additional members, they need to explicitly request them via this operation.
The server will send Guild Members Chunk events in response with up to 1000 members per
chunk until all members that match the request have been sent.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#request-guild-members)
"""
struct GuildMembersRequest
   guild_id::Snowflake
   query::String
   limit::Int64
   presences::Bool
   user_ids::Array{Snowflake}
   nonce::String
end


"""struct UpdateVoiceStateRequest

Sent when a client wants to move, join, or disconnect from a voice channel.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-voice-state)
"""
struct UpdateVoiceStateRequest
   guild_id::Snowflake
   channel_id::Snowflake
   self_mute::Bool
   self_deaf::Bool
end

const OnlineStatus = "online"
const DoNotDisturbStatus = "dnd"
const IdleStatus = "idle"
const InvisibleStatus = "invisible"
const OfflineStatus = "offline"

"""struct UpdatePresenceRequest

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-presence)
"""
struct UpdatePresenceRequest
   since::UInt64
   activities::Array{Activity}
   status::String
   afk::Bool
end


## EVENTS #########################################################################################

struct HeartbeatResponse
   heartbeat_interval::UInt64
end

struct HelloEvent
   opcode::UInt64
   data::HeartbeatResponse
end


"""struct ReadyEvent
"""
struct ReadyEvent
   version::UInt64
   user::UserObject
   guilds::Array{UnavailableGuildObject}
   session_id::String
   shard::Array{UInt64}
   application::ApplicationObject
end
