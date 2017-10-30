# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="niftyled cat tool"
HOMEPAGE="http://wiki.niftylight.de/ledcat"
# removed git:// style URI to avoid security warnings
EGIT_REPO_URI="https://github.com/niftylight/ledcat.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug imagemagick"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="media-gfx/niftyled
	imagemagick? ( media-gfx/imagemagick )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare()
{
	default
	eautoreconf
}

src_unpack()
{
	git-r3_src_unpack
}

src_configure()
{
	econf \
	    $(use_enable debug) \
	    $(use_enable imagemagick)
}

src_install()
{
	emake DESTDIR="${D}" install
	einstalldocs
}

pkg_postinst()
{
	echo
	einfo "Sample configs come with libniftyled. Find them in"
	einfo "/usr/share/niftyled/examples/"
	einfo "Copy config to ~/.ledcat.xml or use the -c argument"
	einfo "to select a config. For further information,"
	einfo "see documentation at http://wiki.niftylight.de/${PN}"
	echo
}
