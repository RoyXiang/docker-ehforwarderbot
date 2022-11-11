#!/usr/bin/env bash

TELEGRAM_DB=/app/.ehforwarderbot/profiles/default/blueset.telegram/tgdata.db
if [ -f "$TELEGRAM_DB" ]; then
    /usr/bin/sqlite3 "$TELEGRAM_DB" "DELETE FROM msglog WHERE time < date('now','-7 day'); VACUUM"
fi
