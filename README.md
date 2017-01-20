BarSim
======

A fake keno game for a bar in my family's basement.

### Try it out

To build the app, clone the repo and use the `Makefile` like so:

```shell
# To Build the app as an index.html
$ make build

# Open the app in a browser
$ xdg-open dist/index.html # Linux
$ open dist/index.html     # Mac

# To Clean up after yourself
$ make clean

# To dev around, use reactor
$ make reactor
```
