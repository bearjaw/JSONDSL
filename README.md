# JSONDSL

Define and compose JSON with Swift enums. Just exploring the concepts of DSLs.


```swift
let doc = object([
    .string("name", "Doc"),
    .integer("dogs", 1)
])

let marty = object("bestFriend",[
    .string("name", "Marty"),
    .integer("dogs", 0)
])

let jsonString = render(
    object([
        string("model", "Dolorian"),
        bool("isNew", false),
        integer("seats", 2),
        marty,
        array("owners", [
            doc
        ])
    ])
)
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
