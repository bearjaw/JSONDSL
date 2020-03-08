# JSONDSL

Define and compose JSON with Swift enums. Just exploring the concepts of DSLs and pushing the boundaries of usefulness.
This is just a playground to play around with and can be improved in many ways.

## What's in this playground?

This playground includes a single recursive `enum` and some free functions to define `JSON` objects entirely in Swift.
A future iteration could parse the object definition into a dictionary `[String: Any]` and use `JSONSerialization` or an Encoder to create `JSON` files.

Current state:

```swift
let doc = object([
    .string("name", "Doc"),
    .integer("dogs", 1)
])

let marty = object("bestFriend",[
    .string("name", "Marty"),
    .integer("dogs", 0)
])

object([
    string("model", "Dolorian"),
    bool("isNew", false),
    integer("seats", 2),
    marty,
    array("owners", [
        doc
    ])
])
```

Produces the following `JSON` Object:

```json
{
  "model": "Dolorian",
  "isNew": false,
  "seats": 2,
  "bestFriend": {
    "name": "Marty",
    "dogs": 0
  },
  "owners": [
    {
      "name": "Doc",
      "dogs": 1
    }
  ]
}
```

After calling the `render` function. Future iteration could also include a validator to make sure that one can only create valid `JSON` objects which is much safer than relying on just a simple String.

Making JSONObject conform to `ExpressibleByArrayLiteral` reduces clutter:

```swift
let jsonString_expressible_by_array_literal = render(
    [
        string("model", "Dolorian"),
        bool("isNew", false),
        integer("seats", 2),
        marty,
        array("owners", [
            doc
        ])
    ]
)
```

## Why?

This is just a quick fun project to explore free functions, DSLs, and composition. It can be quite useful in future iterations to generate test data and have it checked by a compiler instead of just strings.
