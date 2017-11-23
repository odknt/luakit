--- Test utf8 clib functionality.
--
-- @copyright 2017 Dennis Hofheinz <github@kjdf.de>

local assert = require "luassert"

local T = {}

T.test_module = function ()
    assert.is_table(utf8)
end

T.test_utf8_len = function ()
    assert.equal(0, utf8.len(""))
    assert.equal(1, utf8.len("ä"))
    assert.equal(2, utf8.len("äa"))
    assert.equal(1, utf8.len("äa", -1))
    assert.equal(2, utf8.len("äa", -3))
    assert.equal(1, utf8.len("äa", 1, 1))
    assert.equal(1, utf8.len("äa", 1, 2))
    assert.equal(2, utf8.len("äa", 1, 3))
    -- corner cases and errors
    assert.equal(0, utf8.len("", 1, 0))
    assert.equal(0, utf8.len("äa", 4))
    assert.equal(0, utf8.len("äa", 3, 2))
    assert.has.errors(function() utf8.len("", 1, 1) end)
    assert.has.errors(function() utf8.len("äa", 0) end)
    assert.has.errors(function() utf8.len("äa", 5) end)
end

T.test_utf8_offset = function ()
    assert.equal(1, utf8.offset("äaäaä", 1))
    assert.equal(3, utf8.offset("äaäaä", 2))
    assert.equal(7, utf8.offset("äaäaä", 5))
    assert.equal(9, utf8.offset("äaäaä", 6))
    assert.equal(4, utf8.offset("äaäaä", 2, 3))
    assert.equal(7, utf8.offset("äaäaä", 2, -3))
    -- corner cases and errors
    assert.has.errors(function() utf8.offset("äaäaä", 1, 2) end)
    assert.has.errors(function() utf8.offset("äaäaä", 1, 5) end)
end

T.test_utf8_sub = function ()
    assert.equal("", utf8.sub("äaäaä", 0, 0))
    assert.equal("ä", utf8.sub("äaäaä", 0, 1))
    assert.equal("ä", utf8.sub("äaäaä", 1, 1))
    assert.equal("äa", utf8.sub("äaäaä", 1, 2))
    assert.equal("äaä", utf8.sub("äaäaä", 1, 3))
    assert.equal("äaäa", utf8.sub("äaäaä", 1, 4))
    assert.equal("äaäaä", utf8.sub("äaäaä", 1, 5))
    assert.equal("äaäaä", utf8.sub("äaäaä", 1, -1))
    assert.equal("aä", utf8.sub("äaäaä", 4, -1))
    assert.equal("äaä", utf8.sub("äaäaä", -3, -1))
    assert.equal("äaäaä", utf8.sub("äaäaä", -6))
    assert.equal("äaäaä", utf8.sub("äaäaä", 1, 20))
    assert.equal("", utf8.sub("äaäaä", 1, -20))
    -- corner cases and errors
end

return T

-- vim: et:sw=4:ts=8:sts=4:tw=80
