# Noun vocabulary

Every label must come from this file, or be `unclassified`. Each entry gives the
label, what it means, how to recognize it, and examples from the timeline React
app (`timeline/react-app` in Central-Notes-Repo).

> **Note:** These nouns are specific to the Central-Notes-Repo current events
> React app (`~/Brain/Obsidian/Central-Notes-Repo/timeline/react-app`). The
> definitions, recognition rules, and examples describe that app's structure
> and naming. Do not apply this vocabulary to other codebases without first
> reviewing and adapting it.

## Components

### root component
The top component that owns app-wide state and composes every feature.
- Recognize: default export rendered by `main.tsx`.
- Examples: `App`

### layout component
A component that arranges other components into regions but holds no feature
logic. It takes elements as props (slots) instead of data.
- Recognize: props are `ReactNode` slots such as `sidebar` or `main`.
- Examples: `Layout`

### feature component
A component that is the public entry point of one feature folder. It owns that
feature's UI and, often, its local state.
- Recognize: the `index.tsx` of a folder under `src/components/`.
- Examples: `TagFilterSidebar`, `TimelineMonth`, `DailyReview`,
  `MorningNewspaper`, `EntryContent`, `ReviewNoteContent`

### modal component
A feature component that renders as an overlay and is dismissed through an
`onClose` callback prop.
- Recognize: takes `onClose`; shown and hidden by a parent's state.
- Examples: `ReviewModal`, `DailyReview`, `MorningNewspaper`
- Prefer this label over `feature component` when both fit.

### subcomponent
A component that exists only to serve one feature component. It lives in that
feature's folder and is not imported elsewhere.
- Recognize: a non-`index` file in a feature folder, or a nested feature folder.
- Examples: `TagTreeNode` (the component), `ActiveFilterChips`,
  `TimelineEntry` (the component)

## Hooks

### custom data hook
A function named `use…`, written in this app, that loads or derives data and
returns it with loading and error state.
- Recognize: lives in `src/hooks/`; returns a `Use…Result` object.
- Examples: `useTimelineData`, `useReviewData`

### built-in hook
A hook that React itself provides.
- Examples: `useState`, `useEffect`, `useMemo`, `useCallback`, `useRef`

## Data and values

### props
The input object a component receives, or a single field of it.
- Recognize: a `Props` type, or a destructured component parameter.
- Examples: `Props`, `entries`, `activeFilters`, `slides`

### callback prop
A prop that holds a function the child calls to tell its parent something
happened.
- Recognize: named `on…` and passed in from a parent.
- Examples: `onClose`, `onToggle`, `onRemove`, `onToggleFilter`,
  `onOpenDailyReview`, `onOpenNewspaper`

### event handler
A function defined inside a component and passed to a DOM element or to a
callback prop.
- Recognize: named `handle…`, or an inline arrow in `onClick=`.
- Examples: any `handle…` function in a component body

### state variable
A value held by `useState`, or its setter.
- Recognize: the pair returned by `useState`, e.g. `[x, setX]`.
- Examples: the active filter set in `TagFilterSidebar`

### derived value
A value computed from props or state during render, often with `useMemo`.
- Recognize: assigned from a calculation, not stored in state.
- Examples: the filtered and month-grouped entries in `App`

### constant
A module-level value that never changes at runtime.
- Recognize: `UPPER_SNAKE_CASE` at module scope.
- Examples: `NEWSPAPER_SIZE`, `ENTRIES_DIR`, `OUT_PATH`, `REVIEW_NOTES`

## Types

### data type
A TypeScript interface or type that describes the shape of app data.
- Recognize: declared in `src/types.ts`, or exported next to a component.
- Examples: `TimelineEntry` (the interface), `TagTreeNode` (the interface),
  `ReviewNote`, `ReviewNoteMeta`, `ContentSection`, `Reference`, `Slide`

### props type
A type that describes one component's props.
- Recognize: named `Props`, or `…Props`.
- Examples: `Props` in any component file

### hook result type
A type that describes what a custom data hook returns.
- Examples: `UseTimelineDataResult`, `UseReviewDataResult`

## Functions

### pure utility function
A plain function in `src/utils/` that takes data and returns new data. It has no
side effects and uses no hooks.
- Examples: `filterEntries`, `groupByMonth`, `buildTagTree`, `pickRandom`

### script helper
A function defined inside a build-time script.
- Examples: `isoDate`, `slugify`

## Build pipeline

### build-time script
A Node script that runs before `vite` and turns notes into static files the app
fetches at runtime. Label a script by its name, not by its path.
- Examples: `build-data`, `build-review-html`

### generated data file
A file that a build-time script writes and the app fetches.
- Examples: `timeline-data.json`, `manifest.json`
- This is a file, so label it only when the text names the file by its bare
  name and talks about its role. A path such as `public/timeline-data.json`
  gets no label.

## Fallback

### unclassified
Use this label only when no entry above fits. Never invent a new label.
