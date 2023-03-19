
function remove_container_from_cache {
  sed -i "/$1/d" "$LOCAL_CACHE/container_cache"
}
