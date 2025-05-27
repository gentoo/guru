# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_BINDIR="exe" # 'bin' contains only testing functions
RUBY_FAKEGEM_EXTRAINSTALL="static_docs VERSION"
USE_RUBY="ruby31 ruby32 ruby33 ruby34"
inherit ruby-fakegem

DESCRIPTION="An opinionated language server for Ruby"
HOMEPAGE="https://shopify.github.io/ruby-lsp"
SRC_URI="https://github.com/Shopify/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND+="
	>=dev-ruby/prism-1.2 <dev-ruby/prism-2
	>=dev-ruby/rbs-3 <dev-ruby/rbs-5
	=dev-ruby/language_server-protocol-3.17*
	>=dev-ruby/sorbet-runtime-0.5.10782
"
