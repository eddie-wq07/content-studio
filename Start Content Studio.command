#!/bin/zsh
cd -- "${0:A:h}"
if ! command -v node >/dev/null; then
  print 'Install Node.js 24 from https://nodejs.org, then run this again.'
  read '?Press Enter to close.'
  exit 1
fi
npm start
