# Graph Report - berani_kamaimo  (2026-09-28)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 24 nodes · 21 edges · 8 communities (3 shown, 5 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Community 0
- Community 1
- Community 2
- Community 3
- Community 4

## God Nodes (most connected - your core abstractions)
1. `MyHomePage` - 3 edges
2. `_MyHomePageState` - 3 edges
3. `MainActivity` - 2 edges
4. `MyApp` - 2 edges
5. `build` - 1 edges
6. `_counter` - 1 edges
7. `createState` - 1 edges
8. `_incrementCounter` - 1 edges
9. `main` - 1 edges
10. `title` - 1 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (8 total, 5 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.29
Nodes (6): build, _counter, createState, _incrementCounter, main, title

### Community 1 - "Community 1"
Cohesion: 0.40
Nodes (4): package:berani_kamaimo/main.dart, package:flutter/material.dart, package:flutter_test/flutter_test.dart, main

### Community 2 - "Community 2"
Cohesion: 0.50
Nodes (4): MyHomePage, _MyHomePageState, State, StatefulWidget

## Knowledge Gaps
- **7 isolated node(s):** `build`, `_counter`, `createState`, `_incrementCounter`, `main` (+2 more)
  These have ≤1 connection - possible missing edges. (Counts symbols only; 15 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **5 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `MyHomePage` connect `Community 2` to `Community 0`?**
  _High betweenness centrality (0.063) - this node is a cross-community bridge._
- **Why does `_MyHomePageState` connect `Community 2` to `Community 0`?**
  _High betweenness centrality (0.063) - this node is a cross-community bridge._
- **Why does `MyApp` connect `Community 4` to `Community 0`?**
  _High betweenness centrality (0.063) - this node is a cross-community bridge._
- **What connects `build`, `_counter`, `createState` to the rest of the system?**
  _7 weakly-connected nodes found - possible documentation gaps or missing edges._