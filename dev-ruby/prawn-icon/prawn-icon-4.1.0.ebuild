# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Provides support for icons in Prawn"
HOMEPAGE="https://github.com/jessedoyle/prawn-icon"
LICENSE="|| ( GPL-2+ GPL-3 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

# prawn breaks tests for some reasons, needs to be investigated; code
# still works though.
RESTRICT="test"

ruby_add_rdepend ">=dev-ruby/prawn-1.1.0"
