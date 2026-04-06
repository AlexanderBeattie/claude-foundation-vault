---
name: Circuit Breaker
description: 3-strike failure protocol — halts execution and surfaces root cause
type: law
version: 2.0.0
cache_stable: true
---

## Circuit Breaker (3-Strike Rule)

STRIKE triggers: same tool call fails twice in a row | file write rejected | bash exits non-zero and retry also fails.
ON STRIKE 3: STOP all execution. Report what was attempted, what failed, last known good state. No workarounds.
Strike counter resets to zero on any successful tool call.
