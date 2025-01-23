local _M = {}
function _M.greet(name)
    ngx.say("Greetings from ", name)
end
return _M