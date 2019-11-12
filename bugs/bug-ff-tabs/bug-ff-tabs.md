Bug description:

When launching Firefox from CLI with the option `-new-window` the second URL is ignored.

Steps to reproduce:

Launch the Firefox browser from CLI with the `-new-window` option: 
```shell
firefox -new-window -url https://example.com/1 https://example.com/2 https://example.com/3

```

Actual results:

The command above will result with Firefox opened with only two tabs (https://example.com/1 and https://example.com/3), so basically:

```shell
firefox -new-window -url https://example.com/1 https://example.com/2#THIS_ENTIRE_URL_WILL_BE_IGNORED https://example.com/3
```
The behavior above can be reproduced regardless whether an instance of Firefox is already open or not. The behavior above can be reproduced on Linux Fedora with GNOME, Firefox version 69.0.1.

Expected results:

Firefox should be launched with three tabs open, each tab loading different URL from the list given to the option `-url`.

Other comments:

Without the `-new-window` option the Firefox is opened with three tabs, as expected:
```shell
firefox -url https://example.com/1 https://example.com/2 https://example.com/3
```

With both  `-new-window` and  `-new-tab` options set the command Firefox is opened with three tabs, as expected:
```shell
firefox -new-window -new-tab -url https://example.com/1 https://example.com/2 https://example.com/3
```
