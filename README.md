# andreas' pandoc fork

work in progress....

## Continuous compilation

```
./docker-watch-build.sh
```

Then you can add the `pandoc` binary to another container with

```
export PANDOC_BIN=/path/to/pandoc/.stack-work/install/x86_64-linux/lts-8.16/8.0.2/bin/pandoc
docker run --volumes $PANDOC_BIN:/bin/pandoc my-other-image
```

This will expose the `/pandoc` directory in the other container.
