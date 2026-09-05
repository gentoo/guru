#!/usr/bin/env bash

# All of this is lifted from pkgcore/pkgcheck-action; please see [1] for
# the real brains behind this work. All I've done is moved the logic
# into a standalone bash script so that we're as forge-agnostic as
# possible.
# [1]: https://github.com/pkgcore/pkgcheck-action/graphs/contributors?all=1

# ::(end)group:: is used to mark sections of collapsible CI/CD logs.
runner() {
    echo "::group::${1}"
    shift 1
    "$@"
    local exit=$?
    echo
    echo "::endgroup::"
    return $exit
}

runner "Sync gentoo repo" \
    pmaint sync gentoo
runner "Update repo metadata" \
    pmaint regen --dir ~/.cache/pkgcheck/repos .
runner "Marking workspace safe for git" \
    git config --global --add safe.directory '*'
runner "Run pkgcheck" \
    pkgcheck --color y ci --failures failures.json --exit GentooCI \
    "${PKGCHECK_ARGS}"
scan_exit_status=$?
pkgcheck replay --color y failures.json
exit $scan_exit_status
