
function remove_image_from_cache {
  sed -i "/$1/d" "$LOCAL_CACHE/image_cache"
}