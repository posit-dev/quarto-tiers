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
        if meta["quarto-tiers"]["tier"] then
          version_badge_content = pandoc.utils.stringify(meta["quarto-tiers"]["tier"])
        else
          version_badge_content = pandoc.utils.stringify(meta["quarto-tiers"])
        end
        if meta["quarto-tiers"]["color"] then
          type_badge_content = pandoc.utils.stringify(meta["quarto-tiers"]["color"])
        else
          type_badge_content = "pre-release"
        end
        if meta["quarto-tiers"]["default"] then
          default_type_badge_content = pandoc.utils.stringify(meta["quarto-tiers"]["default"])
        else
          default_type_badge_content = "release"
        end
        if meta["quarto-tiers"]["prefix"] then
          default_prefix_content = pandoc.utils.stringify(meta["quarto-tiers"]["prefix"])
        else
          default_prefix_content = ""
        end

        -- if version_badge_content == version_text then
        --   css_class = "badge-target"
        --   version_type = ' title="' .. type_badge_content .. '"'
        -- else 
        --   -- css_class = "badge-default bg-success"
        --   version_type = ' title="' .. default_type_badge_content .. '"'
        -- end
        
        local style = pandoc.utils.stringify(kwargs['style'])
        if style ~= "" then
          style_text = ' style="' .. style .. '"'
        else
          style_text = ""
        end
        
        if version_text == "Basic" then
          -- posit burgandy
          style_text = ' style="background-color: #9A4665 !important; line-height: 1; font-size: 10px !important; vertical-align: middle;"'
          -- doesn't appear to be applying the badge CSS
          css_class = 'pro-header badge-wb'
        elseif version_text == "Enhanced" then
          -- posit light blue
          style_text = ' style="background-color: #447099 !important; line-height: 1; font-size: 10px !important; vertical-align: middle;"'
          css_class = 'badge-enhanced pro-header'
        elseif version_text == "Advanced" then
          -- posit dark blue
          style_text = ' style="background-color: #213D4F !important; line-height: 1; font-size: 10px !important; vertical-align: middle;"'
          css_class = 'badge-advanced pro-header'
        else 
          -- posit gray
          style_text = ' style="background-color: #404041 !important; line-height: 1; font-size: 10px !important; vertical-align: middle;"'
        end
      else
        -- css_class = "badge-default bg-success"
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
        '<span id="#badge-version" class="pro-header badge ' ..
          css_class .. '"' .. style_text ..
        '>' ..
        version_text ..
        '</span>'
      )
    end
  end
}
