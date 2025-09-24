# Dark Web Crawler (Research PoC)

**WARNING**: This is a proof-of-concept for research only.

The script demonstrates crawling capabilities over Tor for research purposes.

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
