# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit pypi python-r1

DESCRIPTION="An extremely fast Python linter and code formatter, written in Rust"
HOMEPAGE="https://github.com/astral-sh/ruff"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="~dev-util/ruff-${PV}
	${PYTHON_DEPS}"

my_install() {
	python_moduleinto ruff
	python_domodule python/ruff/__{init,main}__.py
	python_domodule python/ruff/_find_ruff.py
}

src_install() {
	python_foreach_impl my_install
}
