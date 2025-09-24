# Dark Web Crawler

Personal crawler for the Dark Web, it crawl `onion` domains and store them in the `seen` file.

## Dependencies

It needs the following packages for your Linux distribution:
- `proxychains4`
- `perl`
- `lynx`

## Installation

```bash
git clone https://github.com/bash-bunny/DW_Crawler.git
cd DW_Crawler
chmod +x dw_crawl.sh
```

## Usage

Feed the `seed` file with the onion URLs you want to crawl, and start the crawler.

```bash
./dw_crawl.sh
```
