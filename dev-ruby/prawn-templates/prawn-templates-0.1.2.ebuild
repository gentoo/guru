# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Provides support for templates in Prawn"
HOMEPAGE="https://github.com/prawnpdf/prawn-templates"
LICENSE="|| ( GPL-2+ GPL-3 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/mocha
	>=dev-ruby/pdf-inspector-1.1.0
	>=dev-ruby/pdf-reader-1.2
	>=dev-ruby/prawn-1.3.0
	)"
