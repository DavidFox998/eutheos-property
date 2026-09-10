# Protocol — SuperBric

The operational protocol layer: `SuperBric.lean`, the bridge object named by the Morningstar identifiers (`Protocol.SuperBric`) used across the Family files and referenced by the downstream repos.

## Overview

A "bric" is the ensemble's unit of verified work (the [p-vs-np](https://github.com/DavidFox998/p-vs-np) scaffold counts 225 of them). A **SuperBric** is a bric that other repos import as a reference point: here it packages the certified constants (1419, the 35 brothers, S-ladder, collision counts) in one importable surface.

## Files

| File | Role |
|---|---|
| `SuperBric.lean` | SuperBric packaging of the certified constants |

## Status

Single-file layer; kept minimal so downstream imports stay stable. For the full honesty protocol (Status OPEN/CERT/CLAIM, `forbidden?` checker, MANIFEST LOCKED), see the **ZProtocol tower** of [p-vs-np](https://github.com/DavidFox998/p-vs-np) — that is the upstream protocol this folder plugs into.
