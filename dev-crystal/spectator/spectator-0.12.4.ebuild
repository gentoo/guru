# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit shards

MY_P="${PN}-v${PV}"
DESCRIPTION="Feature-rich testing framework for Crystal inspired by RSpec"
HOMEPAGE="https://gitlab.com/arctic-fox/spectator"
SRC_URI="https://gitlab.com/arctic-fox/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {ARCHITECTURE,CHANGELOG,CONTRIBUTING,README}.md )

src_prepare() {
	default

	local tests_to_remove=(
		# broken in v0.12.4
		spec/rspec/expectations/contain_exactly_matcher_spec.cr
		spec/spectator/mocks/mock_spec.cr

		# bug #945172
		spec/issues/github_issue_48_spec.cr
	)

	rm "${tests_to_remove[@]}" || die
}

src_test() {
	# adopted from .gitlab-ci.yml
	crystal_spec spec/matchers/ spec/spectator/*.cr
	crystal_spec spec/docs/
	crystal_spec spec/features/
	crystal_spec spec/issues/
	crystal_spec spec/rspec/

	# Build failure
	#crystal_spec spec/spectator/dsl/

	# Compile each test individually, because otherwise
	# up to 3G of RAM are eaten by compilation.
	local t
	for t in spec/spectator/mocks/*; do
		crystal_spec "${t}"
	done
}
