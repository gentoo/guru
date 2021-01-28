# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="An AST-based pattern checker for JavaScript."
HOMEPAGE="
	https://eslint.org
	https://www.npmjs.com/package/eslint
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/babel+code-frame
	dev-node/eslint+eslintrc
	dev-node/ajv
	dev-node/chalk
	dev-node/cross-spawn
	dev-node/debug
	dev-node/doctrine
	dev-node/enquirer
	dev-node/eslint-scope
	dev-node/eslint-utils
	dev-node/eslint-visitor-keys
	dev-node/espree
	dev-node/esquery
	dev-node/esutils
	dev-node/file-entry-cache
	dev-node/functional-red-black-tree
	dev-node/glob-parent
	dev-node/globals
	dev-node/ignore
	dev-node/import-fresh
	dev-node/imurmurhash
	dev-node/is-glob
	dev-node/js-yaml
	dev-node/json-stable-stringify-without-jsonify
	dev-node/levn
	dev-node/lodash
	dev-node/minimatch
	dev-node/natural-compare
	dev-node/optionator
	dev-node/progress
	dev-node/regexpp
	dev-node/semver
	dev-node/strip-ansi
	dev-node/strip-json-comments
	dev-node/table
	dev-node/text-table
	dev-node/v8-compile-cache
"
