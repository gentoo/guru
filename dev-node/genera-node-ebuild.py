#!/usr/bin/python3

import json
import sys, requests, os

pacchetto=sys.argv[1]
vero_nome=pacchetto
if "@" in pacchetto:
	pacchetto=pacchetto.replace("@", "").replace("/", "+")

if "." in pacchetto:
	pacchetto=pacchetto.replace(".", "_")

json_uri="".join(['https://registry.npmjs.org/', vero_nome])
pagina=requests.get(json_uri)
dati=json.loads(pagina.text)
versione=dati["dist-tags"]["latest"]
src_uri=dati["versions"][versione]["dist"]["tarball"]

if not os.path.exists(pacchetto):
	os.mkdir(pacchetto)

with open(os.path.join(pacchetto, "metadata.xml"), "w") as metadata:
	metadata.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
	metadata.write("<!DOCTYPE pkgmetadata SYSTEM \"http://www.gentoo.org/dtd/metadata.dtd\">\n")
	metadata.write("<pkgmetadata>\n")
	metadata.write("\t<maintainer type=\"person\">\n")
	metadata.write("\t\t<email>lssndrbarbieri@gmail.com</email>\n")
	metadata.write("\t\t<name>Alessandro Barbieri</name>\n")
	metadata.write("\t</maintainer>\n")
	metadata.write("\t<upstream>\n")
	if "bugs" in dati.keys():
		bugs_uri=dati["bugs"]["url"]
		metadata.write("".join(["\t\t<bugs-to>", bugs_uri, "</bugs-to>\n"]))

#	manutentori=dati["maintainers"]
#	for m in manutentori:
#		metadata.write("\t\t<maintainer status=\"unknown\">\n")
#		metadata.write("".join(["\t\t\t<email>", m["email"], "</email>\n"]))
#		metadata.write("\t\t</maintainer>\n")

	if "repository" in dati.keys():
		repo=dati["repository"]["url"]
		metadata.write("".join(['\t\t<remote-id type=\"github\">', repo, "</remote-id>\n"]))

	metadata.write("\t</upstream>\n")
	metadata.write("</pkgmetadata>\n")

with open(os.path.join(pacchetto, "".join([pacchetto, "-", versione, ".ebuild"])), "w") as ebuild:
	ebuild.write("# Copyright 1999-2021 Gentoo Authors\n")
	ebuild.write("# Distributed under the terms of the GNU General Public License v2\n\n")
	ebuild.write("EAPI=7\n\n")
	ebuild.write("inherit node\n\n")
	ebuild.write('DESCRIPTION="')
	if "description" in dati.keys():
		descrizione=dati["description"].replace("`","")
		ebuild.write(descrizione)

	ebuild.write('"\n')
	ebuild.write('HOMEPAGE="\n\t')
	if "homepage" in dati.keys():
		homepage=dati["homepage"].split("#")[0]
		ebuild.write(homepage)
		ebuild.write('\n')

	ebuild.write('\thttps://www.npmjs.com/package/')
	ebuild.write(vero_nome)
	ebuild.write('\n"\n')
	if "+" in pacchetto:
		ebuild.write('\nPN_LEFT="${PN%%+*}"')
		ebuild.write('\nPN_RIGHT="${PN#*+}"')
		ebuild.write('\nSRC_URI="https://registry.npmjs.org/@${PN_LEFT}/${PN_RIGHT}/-/${PN_RIGHT}-${PV}.tgz -> ${P}.tgz"\n')

	if "." in vero_nome:
		ebuild.write('\nMYPN="${PN//_/.}"')
		ebuild.write('\nSRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"\n')

	if "license" in dati.keys():
		licenza=dati["license"]
		ebuild.write("".join(['\nLICENSE="', licenza, '"\n']))

	ebuild.write('KEYWORDS="~amd64"')

#	if "devDependencies" in dati["versions"][versione].keys():
#		dipendenze=dati["versions"][versione]["devDependencies"]
#		if dipendenze:
#			ebuild.write('\nIUSE="test"\n')
#			ebuild.write('RESTRICT="!test? ( test )"\n')
#			ebuild.write('\nBDEPEND="\n')
#			ebuild.write('\t${NODEJS_BDEPEND}\n')
#			ebuild.write('\ttest? (\n')
#			for d in dipendenze:
#				if "@" in d:
#					d=d.replace('@','').replace('/','+')
#
#				ebuild.write("".join(['\t\tdev-node/', d, '\n']))
#
#			ebuild.write('\t)\n"')

	if "dependencies" in dati["versions"][versione].keys():
		dipendenze=dati["versions"][versione]["dependencies"]
		if dipendenze:
			ebuild.write('\nRDEPEND="\n')
			ebuild.write('\t${NODEJS_RDEPEND}\n')
			for d in dipendenze:
				if "@" in d:
					d=d.replace('@','').replace('/','+')

				ebuild.write("".join(['\tdev-node/', d, '\n']))

			ebuild.write('"')

	ebuild.write('\n')

