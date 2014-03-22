# A helper that sets up brew!

# Leak a variable to avoid needing brewc on path
case "$0" in
    /*)
        _VM_LOAD_PATH=$0 ;;
    *)
        _VM_LOAD_PATH="`pwd`/$0" ;;
esac
_VM_LOAD_PATH="$(dirname $(dirname "$_VM_LOAD_PATH"))"

function brew!() {
  # Nasty globbing hacks are nasty
  eval __${1}_LIST=$(echo /usr/local/Cellar/$1/*)
  # emulate sh -c "$("${_VM_LOAD_PATH}/bin/brewc" "$1")"
  emulate sh -c "$("${_VM_LOAD_PATH}/bin/brewc" "$1")"
}
