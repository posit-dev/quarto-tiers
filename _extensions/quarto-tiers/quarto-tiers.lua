--[[
# MIT License
#
# Copyright (c) Posit Software, PBC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
]]

return {
  ['tier'] = function(args, kwargs, meta)
    if quarto.doc.is_format("html") then
      quarto.doc.add_html_dependency({
        name = 'quarto-tiers',
        stylesheets = {"quarto-tiers.css"}
      })

      local version_text = pandoc.utils.stringify(args[1])
      if meta["quarto-tiers"] then
        
        local style = pandoc.utils.stringify(kwargs['style'])
        if style ~= "" then
          style_text = ' style="' .. style .. '"'
        else
          style_text = ""
        end
        
        if version_text == "Basic" then
          -- posit blue
          css_class = 'badge-basic'
        elseif version_text == "Enhanced" then
          -- posit light blue
          css_class = 'badge-enhanced'
        elseif version_text == "Advanced" then
          -- posit dark blue
          css_class = 'badge-advanced'
        elseif version_text == "Workbench" then
          -- posit burgundy
          css_class = 'badge-wb'
        else
          -- posit gray
          css_class = 'badge-alt'
        end
      else
        version_type = ' title="' .. default_type_badge_content .. '"'
      end

      -- version_text = default_prefix_content .. version_text
      -- if meta["quarto-tiers"]["changelog"] ~= "" and meta["quarto-tiers"]["changelog"] ~= nil then
      --   changelog = pandoc.utils.stringify(meta["quarto-tiers"]["changelog"])
      --   version_text = '<a ' ..
      --     'href="' .. changelog:gsub("{{version}}", version_text) .. '"' ..
      --     'style="text-decoration: none; color: inherit;"' ..
      --   '>' ..
      --   version_text ..
      --   '</a>'
      -- end

      return pandoc.RawInline(
        'html',
        '<span class="pro-header badge ' ..
          css_class .. '"' .. style_text ..
        '>' ..
        version_text ..
        '</span>'
      )
    end
  end
}
