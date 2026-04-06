# Security Rules

## Pre-Commit Gate

ENFORCE — block commit if any fails:
- [ ] No hardcoded secrets (API keys, tokens, passwords)
- [ ] All user inputs validated at system boundaries
- [ ] Parameterized queries only — no SQL string concatenation
- [ ] HTML output sanitized — no raw user input in innerHTML/templates
- [ ] CSRF protection on all mutating endpoints
- [ ] Auth/authorization verified on every protected route
- [ ] Rate limiting on all public endpoints
- [ ] Error messages expose no stack traces or internal state

## Secret Management

STRICT: Never hardcode secrets in source code.
STRICT: Use environment variables or a secret manager exclusively.
STRICT: Validate required secrets exist at process startup — fail fast.
STRICT: Rotate any secret that may have been exposed — immediately.

## Incident Protocol

On security issue discovery:
1. STOP all other work.
2. INVOKE `security-reviewer` agent.
3. Fix CRITICAL before any further commit.
4. Rotate exposed secrets.
5. Grep entire codebase for similar patterns.

## Model Routing

ENFORCE: Route `security-reviewer` to `opus` model — maximum reasoning required.
