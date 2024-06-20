{ writeShellApplication }:

writeShellApplication {
  name = "gpucache";

  text = ''
    set +u
    if [ "$1" == "-r" ]; then
        echo "Cleaning up caches."
        find "$HOME" -type d -name "GPUCache" -exec rm -r {} +
        echo "Done!"
    elif [ "$1" == "-l" ]; then
        echo "Found caches:"
        find "$HOME" -type d -name "GPUCache"
    else
        echo "Usage:"
        echo "To remove caches: gpucache -r"
        echo "To show caches: gpucache -l"
    fi
  '';
}
