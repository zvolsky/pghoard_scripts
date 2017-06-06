# pghoard_scripts
stupid scripts from my environment, but they provide the restore include partial xlog file - please read my comment in https://github.com/ohmu/pghoard/issues/147

This is just example; however you can write better scripts based on this idea.

- **pgrd** - destroy and recreate cluster using pgdump
- **pgrh** - destroy and recreate cluster using pghoard (phys.backup)
- **prghbb** - re-initialize pghoard's basebackup after the recover
