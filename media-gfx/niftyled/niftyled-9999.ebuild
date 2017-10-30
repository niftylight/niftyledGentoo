# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="library designed to provide an abstract interface for LED/lighting hardware"
HOMEPAGE="http://wiki.niftylight.de/libniftyled"
# removed git:// style URI due to security warnings
EGIT_REPO_URI="https://github.com/niftylight/niftyled.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug gstreamer vlc"

DOCS=( NEWS README.md AUTHORS ChangeLog )

PDEPEND="gstreamer? ( media-plugins/gst-plugins-niftyled )
	vlc? ( media-plugins/niftyled-vlc )"

RDEPEND="dev-libs/niftylog
	dev-libs/niftyprefs
	media-libs/babl"

# we unconditionally build the documentation and don't have a configure option for it, so
# we need to ensure doxygen is installed
DEPEND="${RDEPEND}
	>=app-doc/doxygen-1.8.13-r1
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
	    $(use_enable debug)
}

src_compile()
{
	doxygen -u doc/Doxyfile # update the Doxyfile to avoid warings
	emake
}

src_install()
{
	emake DESTDIR="${D}" install
	einstalldocs
}

pkg_postinst()
{
	einfo "Sample configs are in /usr/share/${PN}/examples/"
	einfo "Copy config to ~/.ledset.xml or use the -c argument"
	einfo "to select a config. For further information,"
	einfo "see documentation at http://wiki.niftylight.de/${PN}"
}
