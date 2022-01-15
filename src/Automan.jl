module Automan

include("Discord.jl")
include("WebSocket.jl")

function startup()
end

export
   Discord,
   startup

end

if abspath(PROGRAM_FILE) == @__FILE__
   Automan.startup()
end
