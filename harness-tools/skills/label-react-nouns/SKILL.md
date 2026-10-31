---
name: label-react-nouns
description: Annotate code symbols with the kind of thing each one is, for education. Reads the noun vocabulary in references/nouns.md, then rewrites an answer (or answers a new question) with a short kind label after each symbol. Manual only — invoke with /label-react-nouns. Do NOT trigger this skill on your own, and do not apply it to ordinary answers.
---

# Symbol kind labeling

Append the kind of each code symbol, in parentheses, after the symbol. The labels
teach a reader what a symbol IS, not what it does.

Example:

- Unlabeled: the blast radius across `WPSuccessStep`, `ReviewStep`, and onboarding.
- Labeled: the blast radius across `WPSuccessStep` (in-place step adapter),
  `ReviewStep` (wizard step component), and onboarding.

## When to run

Run this skill only when the user invokes `/label-react-nouns`. Two inputs are possible.

1. **No argument.** Rewrite your previous answer with labels. Change nothing else.
2. **A question or a text block as the argument.** Answer the question, or rewrite
   the block, with labels applied.

## Procedure

1. Read `references/nouns.md` in this skill directory. It holds the full vocabulary.
2. Find every code span in the target text.
3. Classify each span. Follow the rules below.
4. Write the labeled text.
5. Run the self-check below before you return the text.

## Rules

. . . 

## Self-check

Complete these four checks before you return the text.

1. Count the code spans. Confirm that every in-scope span carries one label.
2. Confirm that every label appears in `references/nouns.md`, or is `unclassified`.
3. Confirm that no symbol carries a label twice.
4. Confirm that no file path, make target, or package name carries a label.
