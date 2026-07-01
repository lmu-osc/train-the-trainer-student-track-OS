---
name: Quarto to PPTX Conversion
description: Best practices for modifying and simplifying Quarto slides for Pandoc PPTX export.
---

# Quarto to PPTX Conversion Best Practices

When converting Quarto (`.qmd`) presentations to PowerPoint (`.pptx`) via Pandoc, complex slide structures often fail to render correctly. To ensure a clean PPTX export, follow these guidelines:

## 1. Slide Level and YAML Configuration
- **Set `slide-level: 2`**: Explicitly set `slide-level: 2` in the YAML header under `pptx`. If you don't do this, and you have a mix of `#` and `##` headings, Pandoc may incorrectly guess the slide level. This results in `##` titles being dumped into the regular content text box instead of the Title placeholder.
```yaml
format:
  pptx:
    slide-level: 2
    reference-doc: path/to/template.pptx
```

## 2. Avoid HTML and Block Wrappers
Pandoc struggles to map complex blocks into PPTX layouts correctly.
- **Remove HTML tags**: Remove `<div style="...">`, `<p>`, and `<br>` tags. For example, don't wrap tables in `<div>`.
- **Callouts**: Do not use `::: {.callout-...}` blocks for PPTX. Pandoc does not render them as nice, styled boxes in PowerPoint. Instead, it simply outputs the callout title (e.g. "Important") in bold, leaves a blank line, and then indents the rest of the text. This rarely looks good. Use regular bold text (e.g., `**Important:**`) instead.
- **Blockquotes**: Avoid using blockquotes (`> `) for regular text. Similar to callouts, Pandoc does not create a visually distinct or styled text box for them in PPTX. It merely indents the text, which is usually not the intended visual effect. Use regular paragraphs instead.

## 3. Image Formatting
- **Inline Images (e.g. Icons in text)**: Avoid using inline images (like a small ORCID icon inside a sentence or paragraph). Pandoc for PPTX often fails to render the image itself and will instead just print the alt-text (e.g. "orcid logo"). Remove small inline icons or move images to their own separate lines.
- **Image Captions**: Be aware that the alt-text in Markdown `![alt text](images/img.png)` is automatically rendered as a visible text caption *below* the image in PPTX. If you just want the image without a caption, leave the brackets empty: `![](images/img.png)`.

## 4. Side-by-Side Content (Columns)
- **Mapping to Two-Content Layouts**: If you want text and an image side-by-side, use Quarto columns. This maps cleanly to side-by-side layouts in PPTX. **Note:** Width percentages (like `width="70%"`) have **no effect** in the PPTX export. Pandoc always maps columns to the fixed placeholder sizes of the master template (z.B. a 50/50 "Two Content" layout).
```markdown
:::: {.columns}
::: {.column}
![](images/img.png)
:::
::: {.column}
Text goes here...
:::
::::
```

## 5. Using Content Visibility (Exceptions)
If a slide absolutely requires completely different formatting for HTML and PPTX (like a complex Licence slide with images and custom HTML styling), you can use Quarto's conditional visibility blocks. Use this sparingly to avoid maintenance overhead:
```markdown
::: {.content-visible when-format="html"}
Complex HTML formatting here...
:::

::: {.content-visible when-format="pptx"}
Simplified plain text for PPTX here...
:::
```

## 6. Lists
- **Task Lists**: Task lists (`- [ ]`) render poorly in PPTX as unclickable boxes that disrupt text alignment. Convert them to standard bullet points (`- `).
