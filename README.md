# Quarto Tiers Extension For Quarto

`quarto-tiers` is an extension for Quarto to provide a shortcode to display
styled packaging tiers for Posit pro products.

## Installing

This repository is not public, so you cannot use `quarto add` to add it to
your Quarto project using the `rstudio/quarto-tiers` GitHub repository path.

Instead, clone the repository locally and then call `quarto add` with a
file-system path.

```bash
quarto add [path-to-repository]/quarto-tiers
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Enable this extension in your `_quarto.yml` or the document YAML.

```yaml
quarto-tiers:
  tier: true
```

The shortcode `{{< tier <tier> >}}` will display a badge using the default
styling for that tier. The three packaging tiers, "Basic", "Enhanced", and
"Advanced" receive the three tier colors. The "Workbench" receives Posit
maroon. Other tier names use the Posit dark gray.

```markdown
{{< tier Basic >}}
{{< tier Enhanced >}}
{{< tier Advanced >}}
{{< tier Workbench >}}
{{< tier Alternate >}}
```

![examples](example.png)

The tier shortcode is allowed anywhere, including headers, tables, and as
inline text.

Additional CSS styles can be provided with the `style` parameter which will be
added to the badge as inline CSS.

```markdown
{{< tier Basic style="font-style: italic;" >}}
```

![italic example](italic.png)

The extension also provides five CSS classes: `badge-basic`, `badge-enhanced`, `badge-advanced`, `badge-wb`, and `badge-alt` that can be used to style the badges.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
