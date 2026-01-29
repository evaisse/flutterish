# Flutterish Architecture: Server-Driven UI (SDUI)

This document outlines the architecture for transforming `flutterish` into a React-Admin compliant, server-driven framework for Flutter.

## 1. Overview

The goal is to allow developers (or servers) to define the entire application structure and logic via a JSON configuration, which `flutterish` interprets to render the UI. This mimics the declarative nature of React-Admin but moves the composition to runtime (or server-side).

## 2. Core Concepts

### 2.1 Admin Shell
The `Admin` widget is the entry point. It requires:
- `dataProvider`: Fetches content data (users, posts, etc.).
- `authProvider`: Handles authentication.
- `schemaProvider`: Fetches the UI configuration (JSON).

### 2.2 UI Schema (The Build API)
The UI is defined by a JSON object.

**Structure:**
```json
{
  "title": "My Admin",
  "layout": "Layout",
  "resources": [
    {
      "name": "posts",
      "list": {
        "type": "List",
        "props": { "title": "All Posts" },
        "children": [
          {
            "type": "Datagrid",
            "children": [
              { "type": "TextField", "props": { "source": "id" } },
              { "type": "TextField", "props": { "source": "title" } }
            ]
          }
        ]
      }
    }
  ]
}
```

### 2.3 Component Registry
A central registry maps string keys (e.g., "Datagrid", "TextField") to Flutter widget builders.
`Map<String, Widget Function(Map<String, dynamic> props, List<Widget> children)>`

### 2.4 Data Provider Interface
Mirrors React-Admin's `dataProvider`:
- `getList(resource, params)`
- `getOne(resource, params)`
- `update(resource, params)`
- ...

## 3. State Management (Riverpod)
- **SchemaState**: Stores the current parsed UI configuration.
- **ResourceState**: Stores the data for the current view (list or details).
- **NavigationState**: Tracks the current route/resource.

## 4. Directory Structure
- `lib/src/core/`: Engine, Interfaces, Providers.
- `lib/src/ui/`: The concrete implementation of components (Datagrid, List, etc.).
- `lib/src/components/`: Reusable primitive widgets.
