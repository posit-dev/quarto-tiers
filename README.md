# Quaarto Tiers Extension For Quarto

`quarto-tiers` is an extension for Quarto to provide a shortcode to display software version.

## Installing

```bash
quarto add rstudio/quarto-tiers
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

The shortcode `{{< tier <tier> style=<CSS style> >}}` will display a badge with the given tier styling.

If `<tier>` matches "Basic", "Enhanced", or "Advanced" then it will display with the 3 tier colors, otherwise it will default to a Posit dark grey.

Specify the `quarto-tiers` in the YAML as so:

  ```yaml
  quarto-tiers:
    tier: all
  ```

Additional CSS styles can be provided with the `style` parameter which will be added to the badge as inline CSS.

The extension also provides two CSS classes: `.badge-default` and `.badge-target` that can be used to style the badge.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
