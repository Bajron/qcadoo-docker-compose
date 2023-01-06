# qcadoo-docker-compose
A set of scripts to try [qcadoo](https://www.qcadoo.com/open-sourceq/).

See also https://github.com/qcadoo/mes

It is more or less based on this [instruction](https://qcadoo.atlassian.net/wiki/spaces/QCDMESDOC/pages/535232545/Installation+Guide+for+Ubuntu+-+English)

## Solved issues

With the release I used, there is a problem when using latest PostgreSQL.
The DB driver does not support `scram-sha-256` for password encryption.
Current solution enforces `md5` setting for password encryption.
It will probably not be needed in future versions of **qcadoo**.

## Running
If you have docker and docker-compose, simply

```
docker-compose build
docker-compose up
```
or
```
docker-compose up --build -d
```

If you are not afraid of scripts calling `sudo` and installing stuff.
On Ubuntu (or something with `apt-get`) you can try `./init.sh`.

Then visit http://localhost:8080

You also get adminer on http://localhost:8888

## Stopping

A hint about `docker-compose`.

You can stop the services with `Ctrl+C` when you run it in foreground mode.
You can also run `docker-compose stop` from another terminal with the same effect. After just stopping the services, they will restart after you reboot the computer.

If you want to remove the services, and do not run them with every reboot, execute `docker-compose down`.

## Configuration

You can find the DB password in `secrets` directory.

Ports (and many other things) can be adjusted in the `compose.yml` file.

## Known issues

There are some mounts for logs and database,
but the permissions are not handled nicely yet.
You can clean it up with something like `sudo rm ./logs/*.log` or `sudo rm -rf ./database/pgdata`.
