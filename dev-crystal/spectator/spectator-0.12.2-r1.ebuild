# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_P="${PN}-v${PV}"
DESCRIPTION="Feature-rich testing framework for Crystal inspired by RSpec"
HOMEPAGE="https://gitlab.com/arctic-fox/spectator"
SRC_URI="https://gitlab.com/arctic-fox/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# broken tests
RESTRICT="test"

DOCS=( {ARCHITECTURE,CHANGELOG,CONTRIBUTING,README}.md )

src_prepare() {
	default

	local tests_to_remove=(
		# bug #945172
		spec/issues/github_issue_48_spec.cr
	)

	rm "${tests_to_remove[@]}" || die
}

src_test() {
	# adopted from .gitlab-ci.yml
	shards_src_test spec/matchers/ spec/spectator/*.cr
	shards_src_test spec/docs/
	shards_src_test spec/features/
	shards_src_test spec/issues/
	shards_src_test spec/rspec/

	# Build failure
	#shards_src_test spec/spectator/dsl/

	# Compile each test individually, because otherwise
	# up to 3G of RAM are eaten by compilation.
	local t
	for t in spec/spectator/mocks/*; do
		shards_src_test "${t}"
	done
}
