curl -s --compressed https://feeds.feedburner.com/GoogleChromeReleases | \
grep -Eo "Browser version:&amp;nbsp;&lt;b&gt;[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | \
sed -E 's/.*&lt;b&gt;([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/' | \
head -n 1