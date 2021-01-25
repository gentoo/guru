#!/usr/bin/python3

import json
import sys, requests, os

pacchetto=sys.argv[1]
vero_nome=pacchetto
if "@" in pacchetto:
	pacchetto=pacchetto.replace("@", "").replace("/", "+")

json_uri="".join(['https://registry.npmjs.org/', vero_nome])
pagina=requests.get(json_uri)
dati=json.loads(pagina.text)
descrizione=dati["description"].replace("`","")
licenza=dati["license"]
manutentori=dati["maintainers"]
versione=dati["dist-tags"]["latest"]
src_uri=dati["versions"][versione]["dist"]["tarball"]
repo=dati["repository"]["url"].split(".", 2)[1]
remote=repo.split("/", 1)[1]

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

#	for m in manutentori:
#		metadata.write("\t\t<maintainer status=\"unknown\">\n")
#		metadata.write("".join(["\t\t\t<email>", m["email"], "</email>\n"]))
#		metadata.write("\t\t</maintainer>\n")

	metadata.write("".join(['\t\t<remote-id type=\"github\">', remote, "</remote-id>\n"]))
	metadata.write("\t</upstream>\n")
	metadata.write("</pkgmetadata>\n")

with open(os.path.join(pacchetto, "".join([pacchetto, "-", versione, ".ebuild"])), "w") as ebuild:
	ebuild.write("# Copyright 1999-2021 Gentoo Authors\n")
	ebuild.write("# Distributed under the terms of the GNU General Public License v2\n\n")
	ebuild.write("EAPI=7\n\n")
	ebuild.write("inherit node-guru\n\n")
	ebuild.write("".join(['DESCRIPTION="', descrizione, '"\n']))
	ebuild.write('HOMEPAGE="\n\t')
	if "homepage" in dati.keys():
		homepage=dati["homepage"].split("#")[0]
		ebuild.write(homepage)

	ebuild.write('\n\thttps://www.npmjs.com/package/')
	ebuild.write(vero_nome)
	ebuild.write("".join(['\n"\nSRC_URI="', src_uri, ' -> ${P}.tgz"\n']))
	ebuild.write("".join(['LICENSE="', licenza, '"\n']))
	ebuild.write('KEYWORDS="~amd64"\n')
	ebuild.write('RDEPEND="\n')
	ebuild.write('\t${DEPEND}\n')
	if "dependencies" in dati["versions"][versione].keys():
		dipendenze=dati["versions"][versione]["dependencies"]
		for d in dipendenze:
			if "@" in d:
				d=d.replace('@','').replace('/','+')
				ebuild.write("".join(['\tdev-node/', d, '\n']))

	ebuild.write('"')
