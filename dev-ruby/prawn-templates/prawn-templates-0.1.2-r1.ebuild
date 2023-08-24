# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Provides support for templates in Prawn"
HOMEPAGE="https://github.com/prawnpdf/prawn-templates"
LICENSE="|| ( GPL-2+ GPL-3 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE=""

# prawn breaks tests for some reasons, needs to be investigated; code
# still works though.
RESTRICT="test"

ruby_add_rdepend "
	>=dev-ruby/pdf-reader-1.2
	>=dev-ruby/prawn-0.11.1
	"

ruby_add_bdepend "test? ( dev-ruby/mocha
	>=dev-ruby/pdf-inspector-1.1.0
	>=dev-ruby/prawn-1.3.0
	)"
