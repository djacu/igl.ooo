# lemmy.igl.ooo

## postgres

get access to the database

```
sudo -i -u postgres psql
```

destroy the old database (don't do this often)

```
DROP DATABASE "lemmy";
```

by force if necessary

```
DROP DATABASE "lemmy" WITH (FORCE);
```

[backup and restore](https://join-lemmy.org/docs/administration/backup_and_restore.html)
