#
# Common variables
#

APPNAME="ttrss"

# ttrss version
VERSION="17.1"

# Remote URL to fetch ttrss tarball
TTRSS_BINARY_URL="https://tt-rss.org/gitlab/fox/tt-rss/repository/archive.zip?ref=${VERSION}"

#
# Common helpers
#

# Download and extract ttrss binary to the given directory
# usage: extract_ttrss DESTDIR
extract_ttrss() {
  local DESTDIR=$1
  local TMPDIR=$(mktemp -d)

  # retrieve and extract ttrss tarball
  ttrss_tarball="/tmp/ttrss.zip"
  sudo rm -f "$ttrss_tarball"
  wget -q -O "$ttrss_tarball" "$TTRSS_BINARY_URL" \
    || ynh_die "Unable to download ttrss tarball"
  unzip -q "$ttrss_tarball" -d "$TMPDIR" \
    || ynh_die "Unable to extract ttrss tarball"
  sudo rsync -a "$TMPDIR"/tt-rss.git/* "$DESTDIR"
  sudo rm -rf "$ttrss_tarball" "$TMPDIR"
}