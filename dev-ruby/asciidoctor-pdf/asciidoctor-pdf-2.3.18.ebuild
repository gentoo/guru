# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.adoc README.adoc"
RUBY_FAKEGEM_EXTRAINSTALL="data"
RUBY_FAKEGEM_GEMSPEC="asciidoctor-pdf.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="A native PDF converter for AsciiDoc based on Asciidoctor and Prawn"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor-pdf"
SRC_URI="https://github.com/asciidoctor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( app-text/poppler )"

# prawn-2.5.0 is not compatible yet
ruby_add_rdepend "
	>=dev-ruby/asciidoctor-2.0
	>=dev-ruby/concurrent-ruby-1.1
	>=dev-ruby/matrix-0.4
	~dev-ruby/prawn-2.4.0
	>=dev-ruby/prawn-icon-3.0.0
	>=dev-ruby/prawn-svg-0.34.0
	>=dev-ruby/prawn-table-0.2.0
	>=dev-ruby/prawn-templates-0.1.0
	>=dev-ruby/treetop-1.6.0
	"
ruby_add_bdepend "test? (
	>=dev-ruby/chunky_png-1.4.0
	>=dev-ruby/coderay-1.1.0
	>=dev-ruby/pdf-inspector-1.3.0
)"

all_ruby_prepare() {
	rm Gemfile || die

	sed -i -e "s:_relative ': './:" ${RUBY_FAKEGEM_GEMSPEC} || die
}

each_ruby_test() {
	RSPEC_VERSION=3 ruby-ng_rspec -t ~network -t ~visual spec
}
