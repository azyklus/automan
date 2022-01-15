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

""" @enum ApplicationFlags

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
