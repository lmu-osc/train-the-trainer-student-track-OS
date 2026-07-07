---
name: Quarto to PPTX Conversion
description: Best practices for modifying and simplifying Quarto slides for Pandoc PPTX export.
---

# Quarto to PPTX Conversion Best Practices

When converting Quarto (`.qmd`) presentations to PowerPoint (`.pptx`) via Pandoc, complex slide structures often fail to render correctly. This document provides a set of best practices and instructions to help you create a **simplified version** of an existing Quarto presentation. **Alternatively, these guidelines can be used from the very beginning when creating a new presentation from scratch, ensuring it is fully PPTX-compliant right from the start.**

The primary goal of this skill is to adapt or strip away complex HTML wrappers, custom layouts, and Quarto-specific blocks (like callouts) that do not translate well into PowerPoint, while preserving the core content and meaning. By following these guidelines, you ensure a clean, professional, and error-free PPTX export.

## Meta-Information for AI and OSC Members

**Note for OSC Members (Living Document):** This is a "V1" version of this skill. As more presentations are simplified and new issues/solutions arise, please actively expand and update this `SKILL.md`.

### Manual Verification
Always manually check and compare the Quarto and PPTX outputs. While this document provides a strong starting point, rendering to PowerPoint often requires manual tweaking and visual inspection to ensure everything fits perfectly into the standard slide templates.

### Iterative Workflow for Long Presentations
**To Both OSC Members and AI Assistants:** 
When simplifying long presentations, do not attempt to change everything in one single pass. This often leads to chaos, missing elements, or untraceable errors. Instead, perform the simplification **step-by-step**:
1. **Step 1: Slide Level & YAML Configuration** (Check `reference-doc` and `slide-level`).
2. **Step 2: Unsupported Quarto Features** (Remove `::: {.fragment}`, `{.smaller}`; keep `:::incremental`).
3. **Step 3: HTML & Callouts** (Remove `<div>`, use conditional visibility where needed, convert `::: {.callout-...}`).
4. **Step 4: Media & Images** (Fix inline images, clean up alt-texts/captions).
5. **Step 5: Slide Content Limits & Layouts** (Split dense/overloaded slides using `---`, fix columns, convert task lists).
6. **Step 6: Presenter Notes** (Review and reassign `::: {.notes}` if slides were split).

### General Guidelines for AI Assistants
- **Never delete content entirely**: Unless explicitly instructed (e.g., removing HTML wrappers), do not delete content. Simplify the format, but retain the text and meaning.
- **Transparent Reporting**: In your output to the user, provide a clear, transparent list of what was changed in the presentation and why it was modified based on these rules.

### PowerPoint Templates (`reference-doc`)
Pandoc requires **7 specific standard slide layouts** (Title Slide, Title and Content, Section Header, Two Content, Comparison, Title Only, Blank) in a PowerPoint Master file to correctly map Quarto elements to PPTX slides. 
- **Current Default**: We use `template_lmu.pptx` located in the `assets` folder.
- **Creating Custom Templates**: OSC Members can create or adjust custom templates by opening a `.pptx` file in PowerPoint and editing the **Slide Master** view to adjust the design of those 7 standard layouts. If you are unsure, open `template_lmu.pptx` to see how it works and use it as orientation.

---

## 1. Slide Level & YAML Configuration
- **Set `slide-level: 2`**: Explicitly set `slide-level: 2` in the YAML header under `pptx`. If you don't do this, and you have a mix of `#` and `##` headings, Pandoc may incorrectly guess the slide level. This results in `##` titles being dumped into the regular content text box instead of the Title placeholder.
- **Set the `reference-doc`**: As explained above, link to your PowerPoint template here.
```yaml
format:
  pptx:
    slide-level: 2
    reference-doc: assets/template_lmu.pptx
```

## 2. Unsupported Quarto Features
Not all Quarto/RevealJS markdown extensions work in PowerPoint:
- **Supported:** `:::incremental` lists work perfectly in both Quarto and PPTX (Pandoc maps them to PowerPoint's built-in bullet animations).
- **Unsupported:** `::: {.fragment}`, `{.smaller}`, and `{.smallest}` are HTML-specific extensions. Pandoc's PPTX writer ignores them or treats them as generic `<div>` blocks, which usually breaks the PPTX layout. They must be removed.

## 3. HTML & Callouts
Pandoc struggles to map complex blocks into PPTX layouts correctly.
- **Remove HTML tags**: Remove `<div style="...">`, `<p>`, and `<br>` tags. For example, don't wrap tables in `<div>`.
- **Callouts**: Do not use `::: {.callout-...}` blocks for PPTX. Pandoc does not render them as styled boxes in PowerPoint. Instead, it simply outputs the callout title in bold, leaves a blank line, and indents the rest of the text. Use regular bold text (e.g., `**Important:**`) instead.
- **Blockquotes**: Avoid using blockquotes (`> `) for regular text. Pandoc merely indents the text in PPTX. Use regular paragraphs instead.
- **Content Visibility (Exceptions)**: If a slide absolutely requires completely different formatting for HTML and PPTX (e.g., a complex table that needs HTML styling to fit on the screen), use Quarto's conditional visibility blocks to hide the HTML from PPTX and show plain markdown instead:
  ```markdown
  ::: {.content-hidden when-format="pptx"}
  Complex HTML formatting here (this will be shown in HTML, PDF, etc.)...
  :::

  ::: {.content-visible when-format="pptx"}
  Simplified plain text for PPTX here...
  :::
  ```

## 4. Media & Images
- **Inline Images (e.g. Icons in text)**: Avoid using inline images (like a small ORCID icon inside a sentence). Pandoc for PPTX often fails to render the image itself and will instead just print the alt-text (e.g. "orcid logo"). Remove small inline icons or move images to their own separate lines.
- **Image Captions**: The alt-text in Markdown `![alt text](images/img.png)` is automatically rendered as a visible text caption *below* the image in PPTX. If you just want the image without a caption, leave the brackets empty: `![](images/img.png)`.

## 5. Slide Content Limits & Layouts
- **Slide Content Limits**: **Do not overload a slide with content.** If a slide has too much text and/or images, Pandoc will not scale it down to fit. Instead, it will automatically dump the overflow content onto plain, unstyled backup slides. Always stay within the limits of the PowerPoint templates. If necessary, manually split dense slides into multiple distinct slides (using `---`).
- **Side-by-Side Content (Columns)**: If you want text and an image side-by-side, use Quarto columns. This maps cleanly to side-by-side layouts in PPTX. **Note:** Width percentages (like `width="70%"`) have **no effect** in the PPTX export. Pandoc always maps columns to the fixed placeholder sizes of the master template (e.g., a 50/50 "Two Content" layout).
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
- **Task Lists**: Task lists (`- [ ]`) render poorly in PPTX as unclickable boxes that disrupt text alignment. Convert them to standard bullet points (`- `).

## 6. Presenter Notes
- **Review Notes After Splitting**: When you split an overloaded slide into multiple slides (as described in Step 5), remember to review the `::: {.notes}` block at the bottom of the original slide. Distribute the presenter and instructor notes so that they match the newly split slide contents correctly.
