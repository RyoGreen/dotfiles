local M = {}

function M.setup()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Go snippets
    ls.add_snippets("go", {
        -- Function with empty line
        s("func", fmt([[
func {}({}) {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- Method with empty line
        s("method", fmt([[
func ({}) {}({}) {{
{}
}}]], {
            i(1, "receiver"),
            i(2, "name"),
            i(3, "params"),
            i(4, ""),
        })),
        
        -- If statement with empty line
        s("if", fmt([[
if {} {{
{}
}}]], {
            i(1, "condition"),
            i(2, ""),
        })),
        
        -- For loop with empty line
        s("for", fmt([[
for {} {{
{}
}}]], {
            i(1, "condition"),
            i(2, ""),
        })),
    })

    -- Rust snippets
    ls.add_snippets("rust", {
        -- Function with empty line
        s("fn", fmt([[
fn {}({}) {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- If statement with empty line
        s("if", fmt([[
if {} {{
{}
}}]], {
            i(1, "condition"),
            i(2, ""),
        })),
        
        -- For loop with empty line
        s("for", fmt([[
for {} in {} {{
{}
}}]], {
            i(1, "item"),
            i(2, "iterable"),
            i(3, ""),
        })),
        
        -- Match statement with empty line
        s("match", fmt([[
match {} {{
    {} => {{
        {}
    }},
}}]], {
            i(1, "expression"),
            i(2, "pattern"),
            i(3, ""),
        })),
    })

    -- TypeScript/JavaScript snippets
    ls.add_snippets("typescript", {
        -- Function with empty line
        s("func", fmt([[
function {}({}) {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- Arrow function with empty line
        s("arrow", fmt([[
const {} = ({}) => {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- If statement with empty line
        s("if", fmt([[
if ({}) {{
{}
}}]], {
            i(1, "condition"),
            i(2, ""),
        })),
        
        -- For loop with empty line
        s("for", fmt([[
for (let {} of {}) {{
{}
}}]], {
            i(1, "item"),
            i(2, "iterable"),
            i(3, ""),
        })),
    })

    -- JavaScript snippets (same as TypeScript)
    ls.add_snippets("javascript", {
        -- Function with empty line
        s("func", fmt([[
function {}({}) {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- Arrow function with empty line
        s("arrow", fmt([[
const {} = ({}) => {{
{}
}}]], {
            i(1, "name"),
            i(2, "params"),
            i(3, ""),
        })),
        
        -- If statement with empty line
        s("if", fmt([[
if ({}) {{
{}
}}]], {
            i(1, "condition"),
            i(2, ""),
        })),
        
        -- For loop with empty line
        s("for", fmt([[
for (let {} of {}) {{
{}
}}]], {
            i(1, "item"),
            i(2, "iterable"),
            i(3, ""),
        })),
    })
end

return M 