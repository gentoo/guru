# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Provides support for SVG in Prawn"
HOMEPAGE="https://github.com/mogest/prawn-svg"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

ruby_add_rdepend "
	>=dev-ruby/css_parser-1.6.0
	>=dev-ruby/matrix-0.4.2
	>=dev-ruby/prawn-0.11.1
	>=dev-ruby/rexml-3.4.2
"

all_ruby_prepare() {
	# avoid useless dependencies
	sed -i '/rubocop/d' Gemfile || die
	rm -f Gemfile.lock || die
}
