---
name: label-react-nouns
description: Annotate code symbols with the kind of thing each one is, for education. Reads the noun vocabulary in references/nouns.md, then rewrites an answer (or answers a new question) with a short kind label after each symbol. Manual only — invoke with /label-react-nouns. Do NOT trigger this skill on your own, and do not apply it to ordinary answers.
disable-model-invocation: true
argument-hint: "[question or text to label]"
---

# Symbol kind labeling

Append the kind of each code symbol, in parentheses, after the symbol. The labels
teach a reader what a symbol IS, not what it does.

Example:

- Unlabeled: the filter state flows from `TagFilterSidebar` through
  `filterEntries` into `TimelineMonth`, and `useTimelineData` supplies the
  entries.
- Labeled: the filter state flows from `TagFilterSidebar` (feature component)
  through `filterEntries` (pure utility function) into `TimelineMonth` (feature
  component), and `useTimelineData` (custom data hook) supplies the entries.

## When to run

Run this skill only when the user invokes `/label-react-nouns`. Two inputs are possible.

1. **No argument.** Rewrite your previous answer with labels. Change nothing else.
2. **A question or a text block as the argument.** Answer the question, or rewrite
   the block, with labels applied.

The argument, if any, is: $ARGUMENTS

## Procedure

1. Read `references/nouns.md` in this skill directory. It holds the full vocabulary.
2. Find every code span in the target text.
3. Classify each span. Follow the rules below.
4. Write the labeled text.
5. Run the self-check below before you return the text.

## Rules

### Scope

1. Label inline code spans (single backticks) that name a code symbol: a
   component, hook, function, variable, prop, type, constant, or build script.
2. Do not label file paths, folder paths, make or npm script targets, package
   names, shell commands, or literal values such as strings and numbers.
3. Do not label anything inside fenced code blocks.
4. Do not label symbols that appear without backticks.

### Placement and format

5. Put the label directly after the closing backtick, separated by one space:
   `` `Name` (label) ``.
6. Write the label in lowercase, exactly as it appears as a heading in
   `references/nouns.md`.
7. Label a symbol only at its first appearance in the text. Leave later
   appearances bare.
8. Do not change any other wording, punctuation, or structure of the text.

### Classification

9. Classify by what the symbol is in the timeline React app, not by its name
   alone. When unsure, read the source under `timeline/react-app/src/` or
   `timeline/react-app/scripts/` in Central-Notes-Repo to confirm.
10. Some names belong to more than one kind. `TimelineEntry` and `TagTreeNode`
    are both a component and an interface. Use the surrounding text to decide
    which one is meant: rendering, JSX, or props point to the component; fields,
    shape, or typing point to the data type.
11. When two labels fit, pick the more specific one. Examples: `modal component`
    over `feature component`, `callback prop` over `props`.
12. When the text mixes kinds in one span, such as `useState` with a setter,
    label the span by the symbol it names first.
13. When no label fits, use `unclassified`. Never invent a new label.

## Self-check

Complete these four checks before you return the text.

1. Count the code spans. Confirm that the first appearance of every in-scope
   symbol carries one label.
2. Confirm that every label appears in `references/nouns.md`, or is `unclassified`.
3. Confirm that no symbol carries a label twice.
4. Confirm that no file path, make target, or package name carries a label.
