# Tutorial 3 - Continuous Integration with GitHub Actions

Massey University, 159.251 Software Design and Construction.
Based on https://github.com/SE-Design-and-construction/tutorial3.

## Run locally

Prerequisites: JDK 17 and Apache Maven 3.9.x.

```sh
mvn clean test
```

On this computer, use the portable tools in the parent `.tools` directory:

```powershell
powershell -ExecutionPolicy Bypass -File .\run-local.ps1
```

## CI experiment

The `.github/workflows/build.yml` workflow runs `mvn clean test` on pushes
and pull requests to `main`. It also supports manual `workflow_dispatch` runs.
It uses JDK 17 and Maven dependency caching. Action configuration follows the
official [checkout](https://github.com/actions/checkout) and
[setup-java](https://github.com/actions/setup-java) documentation.

Three stages are preserved as separate commits and local tags:

| Stage/tag | Code and tests | Expected result |
| --- | --- | --- |
| `ci-01-baseline` | Original multiplication bug in `subtract`; addition test only | 1 test passes |
| `ci-02-failing-test` | Add `assertEquals(2, c.subtract(4, 2))` | 2 tests, 1 failure: actual value 8 |
| `ci-03-fixed` | Change `return x*y` to `return x-y` | Both tests pass |

The baseline passing does not establish that subtraction is correct: that
behavior was not covered by a test. Adding the regression test exposes the bug.
Fixing the implementation makes the test pass without weakening its assertion.
CI repeats these checks against the code on GitHub.

## Submission

The required deliverables are a **public repository URL** and **real GitHub
Actions screenshots** showing the successful, failing, and repaired builds.
Local Maven logs are supplementary evidence, not a replacement for Actions.

Push the three stages individually, waiting for each workflow to finish before
pushing the next. A single push of the final branch does not run workflows for
all intermediate commits. See `../submission/完成说明.md` in the local workspace
for results and the remaining GitHub steps.
