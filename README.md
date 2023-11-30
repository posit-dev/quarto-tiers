# Quarto Tiers Extension For Quarto

`quarto-tiers` is an extension for Quarto to provide a shortcode to display the product tiers for Posit pro products.

## Installing

This repo is currently not public, so you will need to pull the repo down and copy the `_extensions` folder into your Quarto repo. If we do make it public eventually, we could use the following:

```bash
# currently doesn't work due to lack of auth
quarto add rstudio/quarto-tiers
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

The shortcode `{{< tier <tier> style=<CSS style> >}}` will display a badge with the given tier styling.

If `<tier>` matches "Basic", "Enhanced", or "Advanced" then it will display with the 3 tier colors, Workbench will be Posit maroon, otherwise it will default to a Posit dark grey.

Specify the `quarto-tiers` in the YAML as so:

  ```yaml
  quarto-tiers:
    tier: true
  ```
  
To use the Quarto shortcode, use the following syntax:

```
{{< tier Basic >}} 
```

This should be allowed anywhere, such as headers, in tables, or inline.

Additional CSS styles can be provided with the `style` parameter which will be added to the badge as inline CSS.

The extension also provides five CSS classes: `badge-basic`, `badge-enhanced`, `badge-advanced`, `badge-wb`, and `badge-alt` that can be used to style the badge.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
