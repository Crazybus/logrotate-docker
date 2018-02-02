# Logrotate-docker

An unopinionated super simple container with logrotate installed running cron. Both the crontab and the logrotate.conf are expected to be provided to the container.

* Crontab mounted at `/etc/crontabs/root`
* `logrotate.conf` mounted at `/etc/logrotate.conf`

## Example

The `example` directory contains a working example of a crontab and logrotate configuration and how to test the logrotate rules

Running `make rotate` shows that no files need to be rotated
```
$ make rotate
reading config file /etc/logrotate.conf
Reading state from file: /var/lib/logrotate.status
Allocating hash table for state file, size 64 entries

Handling 1 logs

rotating pattern: /log/audit.log  1048576 bytes (2 rotations)
empty log files are rotated, old logs are removed
considering log /log/audit.log
Creating new state
  Now: 2018-02-02 10:13
  Last rotated at 2018-02-02 10:00
  log does not need rotating (log size is below the 'size' threshold)
```
Run `make logs` to create a file that is over the size threshold as defined in `logrotate.conf`
```
$ make logs
2048+0 records in
2048+0 records out
```

Run `make rotate` again to see the logs being rotated

```
$ make rotate
reading config file /etc/logrotate.conf
Reading state from file: /var/lib/logrotate.status
Allocating hash table for state file, size 64 entries

Handling 1 logs

rotating pattern: /log/audit.log  1048576 bytes (2 rotations)
empty log files are rotated, old logs are removed
considering log /log/audit.log
Creating new state
  Now: 2018-02-02 10:21
  Last rotated at 2018-02-02 10:00
  log needs rotating
rotating log /log/audit.log, log->rotateCount is 2
dateext suffix '-20180202'
glob pattern '-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
renaming /log/audit.log.2 to /log/audit.log.3 (rotatecount 2, logstart 1, i 2),
renaming /log/audit.log.1 to /log/audit.log.2 (rotatecount 2, logstart 1, i 1),
renaming /log/audit.log.0 to /log/audit.log.1 (rotatecount 2, logstart 1, i 0),
log /log/audit.log.3 doesn't exist -- won't try to dispose of it
copying /log/audit.log to /log/audit.log.1
truncating /log/audit.log
```
