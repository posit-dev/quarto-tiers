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

      -- special case for shield icon
      if version_text == "shield" then
        return pandoc.RawInline(
          "html",
          '<i class="bi bi-shield-lock" data-bs-toggle="tooltip" data-bs-placement="top" title="Requires root"></i>'
        )
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

      local style = pandoc.utils.stringify(kwargs['style'])
      local style_text = ""
      if style ~= "" then
        style_text = ' style="' .. style .. '"'
      else
        style_text = ""
      end

      -- Global, then tier, then call-specific configurations for title and URL.

      -- Note: kwargs[NAME] evaluates as truthy even when NAME is not in the
      -- dictionary. This means that we cannot distinguish between NAME="" and
      -- NAME not present in the shortcode.

      local title = pandoc.utils.stringify(kwargs['title'])
      if title == "" then
        if meta["quarto-tiers"] then
          if meta["quarto-tiers"]["title"] then
            title = pandoc.utils.stringify(meta["quarto-tiers"]["title"])
          end
          if meta["quarto-tiers"][version_text] then
            if meta["quarto-tiers"][version_text]["title"] then
              title = pandoc.utils.stringify(meta["quarto-tiers"][version_text]["title"])
            end
          end
        end
      end

      local url = pandoc.utils.stringify(kwargs['url'])
      if url == "" then
        if meta["quarto-tiers"] then
          if meta["quarto-tiers"]["url"] then
            url = pandoc.utils.stringify(meta["quarto-tiers"]["url"])
          end
          if meta["quarto-tiers"][version_text] then
            if meta["quarto-tiers"][version_text]["url"] then
              url = pandoc.utils.stringify(meta["quarto-tiers"][version_text]["url"])
            end
          end
        end
      end

      local title_text = ""
      if title ~= "" then
        title_text = ' title="' .. title .. '"'
      end

      local tag = "span"
      local link_text = ""
      local nav_class = ""
      if url ~= "" then
        tag = "a"
        link_text = ' href="' .. url .. '"'
        -- no-external avoids external-link icons
        nav_class = " no-external"
      end

      local class_text = ' class="badge rounded-pill ' .. css_class .. nav_class .. '"'

      return pandoc.RawInline(
        'html',
        '<' .. tag .. link_text .. title_text .. class_text .. style_text .. '>' ..
        version_text ..
        '</' .. tag .. '>'
      )
    end
  end
}
