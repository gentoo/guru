## Frequently Asked Questions <a name="FAQ"></a>

- #### How do I emerge these ebuilds?

`eselect repository enable guru && emerge --sync` and emerge the package just as usual.

- #### How do I contribute?

See [wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors](https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors)

- #### What are the rules and regulations?

See [wiki.gentoo.org/wiki/Project:GURU#The_regulations](https://wiki.gentoo.org/wiki/Project:GURU#The_regulations)

- #### What does GURU stand for?

This is very secret, but you might find a clue [here](https://dev.gentoo.org/~mgorny/articles/guru-a-new-model-of-contributing-to-gentoo.html#the-acronym).

- #### How to track new releases of packages I maintain?

GitHub and other forges provide RSS/Atom feeds of releases (e.g. `https://github.com/git/git/releases.atom`). You need to install a feed reader (`eix -C net-news`) or a browser add-on to subscribe to them. If a project has no tagged releases, follow new commits feed instead. If a project is not hosted on any forges and has no feeds on its website, subscribe to its announce mailing list.

Also you can use [Repology](https://repology.org/projects/?inrepo=gentoo_ovl_guru&outdated=on) to view all outdated packages in GURU.

- #### [GLEP 63](https://www.gentoo.org/glep/glep-0063.html) says I should use a @gentoo.org email address for signing off, do I need an @gentoo.org email address to contribute to GURU?

No, you do not need an @gentoo.org email address to contribute to GURU, these email addresses are for Gentoo developers only. Instead use whichever email address you want to receive bug mail and other communications on. If you're also a [proxy-maintainer](https://wiki.gentoo.org/wiki/Project:Proxy_Maintainers) please use the same email address.

- #### Can I use RESTRICT="mirror"?

Sure, since GURU packages are not mirrored on the [Gentoo mirrors](https://devmanual.gentoo.org/general-concepts/mirrors/index.html) anyway, it makes no difference. You can use RESTRICT="mirror" to avoid unnecessary fetch attempts. This is not required by GURU nor is it prohibited, just be sure to remove it if you want to move your package to the main Gentoo repository.

- #### I need help, where do I go?

You can reach other GURU contributors on [IRC #gentoo-guru](https://web.libera.chat/#gentoo-guru), or by emailing guru-committers@gentoo.org.

- #### I found a bug, what do I do?

You can either contact the GURU contributors using one of the options in the previous point, or you can open a bug on our bug tracker: [bugs.gentoo.org/enter_bug.cgi?product=GURU](https://bugs.gentoo.org/enter_bug.cgi?product=GURU)

- #### I found a bug in a package that I do not maintain, and I know how to fix it, can I fix it myself?

As per [the regulations](https://wiki.gentoo.org/wiki/Project:GURU#The_regulations), yes, you can! Just be sure to maintain respectful and professional behaviour.

- #### Can I commit a package without listing myself as explicit maintainer?

As per [the regulations](https://wiki.gentoo.org/wiki/Project:GURU#The_regulations), yes, you can.

- #### I want to make changes to this document, can I?

Please discuss any changes and additions to this document on our [bug tracker](https://bugs.gentoo.org/enter_bug.cgi?product=GURU) prior to committing them.
