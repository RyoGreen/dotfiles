local M = {}

local function get_next_string(length)
  local str = ""
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")
  for i = 0, length - 1 do
    str = str .. string.sub(line, col + i, col + i)
  end
  return str
end

local function get_prev_string(length)
  local str = ""
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")
  for i = 0, length - 1 do
    str = string.sub(line, col - i - 1, col - i - 1) .. str
  end
  return str
end

local function is_alphabet(char)
  return char:match("%a") ~= nil
end

local function is_full_width(char)
  return char:match("[^\x01-\x7E]") ~= nil
end

local function is_num(char)
  return char >= "0" and char <= "9"
end

local function is_inside_parentheses(prev_char, next_char)
  return (prev_char == "{" and next_char == "}") or
         (prev_char == "[" and next_char == "]") or
         (prev_char == "(" and next_char == ")")
end

local function input_parentheses(parenthesis)
  local next_char = get_next_string(1)
  local prev_char = get_prev_string(1)
  local parentheses = { ["{"] = "}", ["["] = "]", ["("] = ")" }

  if next_char == "" or next_char == "}" or next_char == "]" or next_char == ")" or next_char == " " then
    return parenthesis .. parentheses[parenthesis] .. "<LEFT>"
  else
    return parenthesis
  end
end

local function input_close_parenthesis(parenthesis)
  local next_char = get_next_string(1)
  if next_char == parenthesis then
    return "<RIGHT>"
  else
    return parenthesis
  end
end

local function input_quot(quot)
  local next_char = get_next_string(1)
  local prev_char = get_prev_string(1)

  local cursor_is_inside_quotes = (prev_char == quot and next_char == quot)
  local next_char_is_empty = (next_char == "")
  local next_char_is_closing_parenthesis = (next_char == "}" or next_char == "]" or next_char == ")")
  local next_char_is_space = (next_char == " ")
  local prev_char_is_alphabet = is_alphabet(prev_char)
  local prev_char_is_full_width = is_full_width(prev_char)
  local prev_char_is_num = is_num(prev_char)
  local prev_char_is_quot = (prev_char == "'" or prev_char == "\"" or prev_char == "`")

  if cursor_is_inside_quotes then
    return "<RIGHT>"
  elseif prev_char_is_alphabet or prev_char_is_num or prev_char_is_full_width or prev_char_is_quot then
    return quot
  elseif next_char_is_empty or next_char_is_closing_parenthesis or next_char_is_space then
    return quot .. quot .. "<LEFT>"
  else
    return quot
  end
end

local function input_cr()
  local next_char = get_next_string(1)
  local prev_char = get_prev_string(1)
  local cursor_is_inside_parentheses = is_inside_parentheses(prev_char, next_char)

  if cursor_is_inside_parentheses then
    return "<CR><ESC><S-o>"
  else
    return "<CR>"
  end
end

local function input_space()
  local next_char = get_next_string(1)
  local prev_char = get_prev_string(1)
  local cursor_is_inside_parentheses = is_inside_parentheses(prev_char, next_char)

  if cursor_is_inside_parentheses then
    return "<Space><Space><LEFT>"
  else
    return "<Space>"
  end
end

local function input_bs()
  local next_char = get_next_string(1)
  local prev_char = get_prev_string(1)
  local next_two_string = get_next_string(2)
  local prev_two_string = get_prev_string(2)

  local cursor_is_inside_parentheses = is_inside_parentheses(prev_char, next_char)
  local cursor_is_inside_space = (prev_two_string == "{ " and next_two_string == " }") or
                                 (prev_two_string == "[ " and next_two_string == " ]") or
                                 (prev_two_string == "( " and next_two_string == " )")
  local exists_quot = (prev_char == "'" and next_char == "'")
  local exists_double_quot = (prev_char == "\"" and next_char == "\"")

  if cursor_is_inside_parentheses or cursor_is_inside_space or exists_quot or exists_double_quot then
    return "<BS><RIGHT><BS>"
  else
    return "<BS>"
  end
end

M.get_next_string = get_next_string
M.get_prev_string = get_prev_string
M.is_alphabet = is_alphabet
M.is_full_width = is_full_width
M.is_num = is_num
M.is_inside_parentheses = is_inside_parentheses
M.input_parentheses = input_parentheses
M.input_close_parenthesis = input_close_parenthesis
M.input_quot = input_quot
M.input_cr = input_cr
M.input_space = input_space
M.input_bs = input_bs

return M
