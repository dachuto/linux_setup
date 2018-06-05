#!/usr/bin/env bash
set -e

vim -E -s /etc/default/keyboard <<-EOF
	:%substitute/^XKBOPTIONS=""/XKBOPTIONS="numpad:microsoft"/
	:update
	:quit
EOF

