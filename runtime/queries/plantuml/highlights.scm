; ------------------------------------------------------------
; PlantUML highlights for Helix (tree-sitter)
; Based on provided node-types.json
; ------------------------------------------------------------

; -----------------
; Comments / Strings
; -----------------
(comment) @comment
(string) @string
(escape_sequence) @string.escape

["'/" "/'"] @comment

; -----------------
; Directives (@start.../@end...)
; -----------------
("@startuml")     @keyword.directive
("@enduml")       @keyword.directive
("@startgantt")   @keyword.directive
("@endgantt")     @keyword.directive
("@startmindmap") @keyword.directive
("@endmindmap")   @keyword.directive
("@startjson")    @keyword.directive
("@endjson")      @keyword.directive
("@startyaml")    @keyword.directive
("@endyaml")      @keyword.directive
("@startsalt")    @keyword.directive
("@endsalt")      @keyword.directive

; -----------------
; Commands / Keywords
; -----------------
; Some grammars emit reserved words as uniqkey
(uniqkey) @keyword

; In your tree, keywords like participant/title/group are identifiers.
; We highlight identifiers under (command) only if they match a whitelist.
(command
  (identifier) @keyword
  (#match? @keyword
    "^(participant|actor|agent|boundary|control|entity|database|collections|queue|usecase|component|interface|class|enum|annotation|abstract|hide|show|skinparam|scale|title|caption|header|footer|legend|note|hnote|rnote|activate|deactivate|destroy|create|autonumber|group|end|alt|else|opt|loop|par|break|critical|ref|return|newpage|box|rectangle|node|frame|cloud|package|namespace|folder|card|file|artifact|storage|start|stop|state|fork|split|repeat|while|if|then|endif|switch|case|endswitch|partition|as|over|left|right|up|down)$"
  )
)

; commandjson/commandyaml nodes exist as standalone named nodes
(commandjson) @keyword
(commandyaml) @keyword

; -----------------
; Methods / Messages / Special vars
; -----------------
(method (identifier) @function)

(message (identifier) @variable.parameter)
(message (string) @string.special)

(uniquevar (identifier) @variable.special)

; -----------------
; Colors
; -----------------
(colorleader) @punctuation.special
(color (identifier) @constant)

; -----------------
; Block style
; IMPORTANT: do NOT force a fixed sequence here (can cause impossible pattern).
; Just highlight identifiers inside block_style as tags.
(block_style (identifier) @tag)
(block_style [":" ">" "</"] @punctuation.special)

; -----------------
; Brackets / Delimiters / Operators / Specials
; -----------------
[
  "(" ")" "()" "[" "]" "{" "}"
] @punctuation.bracket

[
  "," ";" ":" "."
] @punctuation.delimiter

[
  "<" ">" "</" "!" "#" "$"
] @punctuation.special

[
  "+" "-" "*" "/" "="
] @operator
