---
type: index
scope: specialists
count: 28
updated: 2026-04-04
---

# Specialists Manifest

Machine-readable index for grep-based discovery. Fields: id, category, domain, trigger.

## Strategy

| id | category | domain | trigger |
|---|---|---|---|
| architect | strategy | architecture, system-design | planning new features, refactoring large systems, architectural decisions |
| planner | strategy | planning, feature-design | feature implementation requests, architectural changes, complex refactoring |

## Reviewer

| id | category | domain | trigger |
|---|---|---|---|
| code-reviewer | reviewer | general | after writing or modifying any code |
| security-reviewer | reviewer | security, owasp | code handles user input, auth, API endpoints, sensitive data |
| database-reviewer | reviewer | postgresql, sql, supabase | writing SQL, migrations, schema design, database performance |
| typescript-reviewer | reviewer | typescript, javascript | TypeScript/JavaScript code changes |
| python-reviewer | reviewer | python | Python code changes |
| go-reviewer | reviewer | go | Go code changes |
| rust-reviewer | reviewer | rust | Rust code changes |
| java-reviewer | reviewer | java, spring-boot | Java/Spring Boot code changes |
| kotlin-reviewer | reviewer | kotlin, android, kmp | Kotlin/Android/KMP code changes |
| cpp-reviewer | reviewer | c++ | C++ code changes |
| flutter-reviewer | reviewer | flutter, dart | Flutter/Dart code changes |

## Build Resolver

| id | category | domain | trigger |
|---|---|---|---|
| build-error-resolver | build-resolver | typescript, javascript | build fails, type errors, CI red |
| go-build-resolver | build-resolver | go | Go build or vet fails |
| rust-build-resolver | build-resolver | rust, cargo | Rust/Cargo build fails, borrow checker errors |
| java-build-resolver | build-resolver | java, maven, gradle | Java/Spring Boot build fails |
| kotlin-build-resolver | build-resolver | kotlin, gradle | Kotlin/Gradle build fails |
| cpp-build-resolver | build-resolver | c++, cmake | C++/CMake build or linker fails |
| pytorch-build-resolver | build-resolver | pytorch, cuda, ml | PyTorch training/inference crashes, CUDA errors |

## Testing

| id | category | domain | trigger |
|---|---|---|---|
| tdd-guide | testing | tdd | writing new features, fixing bugs, refactoring |
| e2e-runner | testing | e2e, playwright | generating/running E2E tests, flaky test quarantine |

## Ops

| id | category | domain | trigger |
|---|---|---|---|
| refactor-cleaner | ops | refactoring, dead-code | removing unused code, duplicates, dead code cleanup |
| doc-updater | ops | documentation, codemaps | updating codemaps, READMEs, project documentation |
| docs-lookup | ops | documentation, api-reference | questions about libraries, frameworks, or APIs |
| harness-optimizer | ops | agent-harness | analyzing/improving agent harness configuration |
| loop-operator | ops | agent-ops | autonomous agent loops stall or need intervention |

## Communication

| id | category | domain | trigger |
|---|---|---|---|
| chief-of-staff | comms | email, slack, line, messenger | managing multi-channel communication workflows, message triage |
