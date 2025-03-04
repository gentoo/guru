# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_BINDIR="exe" # this directory doesn't actually exist, but reflects the spec
USE_RUBY="ruby31 ruby32 ruby33 ruby34"

inherit ruby-fakegem

DESCRIPTION="Language Server SDK Gem for Ruby"
HOMEPAGE="https://github.com/mtsmfm/language_server-protocol-ruby"
SRC_URI="https://github.com/mtsmfm/${PN}-ruby/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

all_ruby_unpack() {
	default

	# git repo is titled "language_server-protocol-ruby" by default
	# change to match package name to make eclass happy
	mv "${PN}-ruby-${PV}" "${P}"
}

each_fakegem_configure() {
	# by default these lines contain code that runs unnecessary shell commands or
	# searches that don't make sense with the ebuild directory structure.
	# values are set independently by the eclass anyways, so can be removed
	sed -i '/^spec.files*/d' "${PN}.gemspec" || die
	sed -i '/^spec.executables*/d' "${PN}.gemspec" || die

	default
}
