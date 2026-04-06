# Testing Rules

## Coverage Floor

ENFORCE: 80% minimum test coverage. Block merge below this threshold.

Test types — ALL required:
- **Unit**: Individual functions, utilities, components
- **Integration**: API endpoints, database operations
- **E2E**: Critical user flows

## TDD Cycle

STRICT: Tests first. Implementation second. Never inverted.

1. Write test → RED (must fail)
2. Write minimal implementation → GREEN (must pass)
3. Refactor → IMPROVE (coverage must hold)

## Failure Protocol

On test failure:
1. INVOKE `tdd-guide` agent.
2. Check test isolation.
3. Verify mock correctness.
4. Fix implementation — not tests (unless tests are provably wrong).

## Agent

REQUIRE: Invoke `tdd-guide` proactively for new features and bug fixes — do not wait for failures.
