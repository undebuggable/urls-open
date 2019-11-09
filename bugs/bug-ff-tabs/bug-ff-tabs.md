When launching Firefox from CLI with the parameter `-new-window` the second URL is ignored.

The command below will result with Firefox opened with only two tabs (https://example.com/1 and https://example.com/3):
```shell
firefox -new-window -url https://example.com/1 https://example.com/2 https://example.com/3

```
so basically
```shell
firefox -new-window -url https://example.com/1 https://example.com/#THIS_ENTIRE_URL_WILL_BE_IGNORED https://example.com/3
```

The behavior above can be reproduced reliably regardless whether an instance of Firefox is already open or not on Linux Fedora with GNOME, Firefox version 69.0.1.

Without the `-new-window` parameter, the command works as expected. The command below opens Firefox with three tabs:
```shell
firefox -url https://example.com/1 https://example.com/2 https://example.com/3
```
