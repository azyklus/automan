using Dates


## ENUMERATIONS ###################################################################################

"""@enum GatewayIntents

TODO: document this enumeration.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#list-of-intents)
"""
@enum GatewayIntents begin
   Guilds = 1 << 0
   GuildMembers = 1 << 1
   GuildBans = 1 << 2
   GuildEmojisStickers = 1 << 3
   GuildIntegrations = 1 << 4
   GuildWebhooks = 1 << 5
   GuildInvites = 1 << 6
   GuildVoiceStates = 1 << 7
   GuildPresences = 1 << 8
   GuildMessages = 1 << 9
   GuildMessageReactions = 1 << 10
   GuildMessageTyping = 1 << 11
   DirectMessages = 1 << 12
   DirectMessageReactions = 1 << 13
   DirectMessageTyping = 1 << 14
   GuildScheduledEvents = 1 << 16
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


"""@enum ActivityTypes

TODO: document this enumeration.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activitytype-enum)
"""
@enum ActivityTypes begin
   Playing = 0
   Streaming = 1
   Listening = 2
   Watching = 3
   Custom = 4
   Competing = 5
end


## GATEWAY ########################################################################################

"""mutable struct GatewayConnection

Represents a connection request to the Discord gateway.

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#connecting)
"""
mutable struct GatewayConnection
   version::String
   encoding::String
   compress::Union{String, Nothing}
end


"""function GatewayConnection(version)

Creates a new `GatewayConnection` with the supplied version
and the default values.
"""
GatewayConnection(version) = GatewayConnection(version, "json", nothing)


"""function GatewayConnection(version, encoding)

Creates a new `GatewayConnection` with the supplied version and encoding values.
"""
function GatewayConnection(version, encoding)
   conn = undef

   if encoding in ("json", "etf")
      conn = GatewayConnection(version, encoding, nothing)
   else
      conn = GatewayConnection(version, "json", nothing)
   end

   return conn
end


"""function get_gateway_url(conn)

Creates a string representing the URL to the Discord gateway.
"""
function get_gateway_url(conn::GatewayConnection)
   return "wss://gateway.discord.gg/?v=$(conn.version)&encoding=$(conn.encoding)"
end


GATEWAY_INSTANCE = GatewayConnection("9", "json", nothing)

"""variable DISCORD_GATEWAY

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway)
"""
DISCORD_GATEWAY = get_gateway_url(GATEWAY_INSTANCE)


const Snowflake = Int64


const OnlineStatus = "online"
const OfflineStatus = "offline"
const DoNotDisturbStatus = "dnd"
const IdleStatus = "idle"


## OBJECTS ########################################################################################

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


"""struct ThreadMetadataObject


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/channel#thread-metadata-object)
"""
struct ThreadMetadataObject
   archived::Bool
   auto_archive_duration::Int64
   archive_timestamp::DateTime
   locked::Bool
   invitable::Bool
end


"""struct ThreadMemberObject


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/channel#thread-member-object)
"""
struct ThreadMemberObject
   id::Snowflake
   user_id::Snowflake
   join_timestamp::DateTime
   flags::Int64
end


"""struct PermissionOverwrite


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/channel#overwrite-object)
"""
struct PermissionOverwriteObject
   id::Snowflake
   type::Int64
   allow::String
   deny::String
end


"""struct GuildChannelObject


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/channel#channels-resource)
"""
struct GuildChannelObject
   id::Snowflake
   type::Int64
   guild_id::Snowflake
   position::Int64
   permission_overwrites::Array{PermissionOverwriteObject}
   name::String
   topic::String
   nsfw::Bool
   last_message_id::Snowflake
   bitrate::Int64
   user_limit::UInt64
   rate_limit_per_user::Int64
   recipients::Array{UserObject}
   icon::String
   owner_id::Snowflake
   application_id::Snowflake
   parent_id::Snowflake
   last_pin_timestamp::DateTime
   rtc_region::String
   video_quality_mode::Int64
   message_count::Int64
   member_count::Int64
   thread_metadata::ThreadMetadataObject
   member::ThreadMemberObject
   default_auto_archive_duration::UInt64
   permissions::String
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


"""struct GuildMembersObject


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#request-guild-members)
"""
struct GuildMembersObject
   guild_id::Snowflake
   query::String
   limit::Int64
   presences::Bool
   user_ids::Array{Snowflake}
   nonce::String
end


"""struct UpdateVoiceStateObject


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-voice-state)
"""
struct UpdateVoiceStateObject
   guild_id::Snowflake
   channel_id::Snowflake
   self_mute::Bool
   self_deaf::Bool
end


"""struct ActivityTimestampsObject

Represents a set of timestamps for an activity.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activitytimestamps-struct)
"""
struct ActivityTimestampsObject
   start::UInt64
   finish::UInt64
end

"""struct ActivityAssetsObject

TODO: document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activityassets-struct)
"""
struct ActivityAssetsObject
   large_image::String
   large_text::String
   small_image::String
   small_text::String
end

"""struct ActivityPartySizeObject

TODO: Document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-partysize-struct)
"""
struct ActivityPartySizeObject
   current::Int32
   max::Int32
end

"""struct ActivityPartyObject

TODO: Document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activityparty-struct)
"""
struct ActivityPartyObject
   id::String
   size::ActivityPartySizeObject
end

"""struct ActivitySecretsObject

TODO: document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activitysecrets-struct)
"""
struct ActivitySecretsObject
   match::String
   join::String
   spectate::String
end

"""struct ActivityObject

TODO: Document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/game-sdk/activities#data-models-activity-struct)
"""
struct ActivityObject
   id::Snowflake
   name::String
   state::String
   details::String
   timestamps::ActivityTimestampsObject
   assets::ActivityAssetsObject
   party::ActivityPartyObject
   secrets::ActivitySecretsObject
   instance::Bool
end


"""struct UpdatePresenceObject

TODO: Document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-presence)
"""
struct UpdatePresenceObject
   since::UInt64
   activities::Array{ActivityObject}
   status::String
   afk::Bool
end


"""struct UnavailableGuildObject

TODO: Document this structure.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/resources/guild#unavailable-guild-object-example-unavailable-guild)
"""
struct UnavailableGuildObject
   id::Snowflake
   unavailable::Bool
end


## REQUESTS #######################################################################################

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
   opcode::Int64
   data::GuildMembersObject
end


"""struct UpdateVoiceStateRequest

Sent when a client wants to move, join, or disconnect from a voice channel.


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-voice-state)
"""
struct UpdateVoiceStateRequest
   opcode::Int64
   data::UpdatePresenceObject
end


"""struct UpdatePresenceRequest

## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#update-presence)
"""
struct UpdatePresenceRequest
   opcode::Int64
   data::UpdatePresenceObject
end


## EVENTS #########################################################################################

struct HeartbeatEventResponse
   heartbeat_interval::UInt64
end

struct HelloEvent
   opcode::UInt64
   data::HeartbeatEventResponse
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
   opcode::Int64
   data::Int64
end


"""struct HeartbeatAck


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#heartbeat)
"""
struct HeartbeatAck
   opcode::Int64
end


"""struct GatewayInvalidSession
"""
struct InvalidSession
   opcode::Int64
   data::Bool
end


"""struct ChannelCreateEvent


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#channel-create)
"""
struct ChannelCreateEvent
   opcode::Int64
   data::GuildChannelObject
end


"""struct ChannelUpdateEvent


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#channel-update)
"""
struct ChannelUpdateEvent
   opcode::Int64
   data::GuildChannelObject
end


"""struct ChannelDeleteEvent


## Resources

- [Discord API documentation](https://discord.com/developers/docs/topics/gateway#channel-delete)
"""
struct ChannelDeleteEvent
   opcode::Int64
   data::GuildChannelObject
end
