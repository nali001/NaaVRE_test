counter=0
for file in ./*/
do
  if [ $counter -ge 1 ]; then
    cd ../
  fi
  echo "$file"
  cd "$file" || exit
  wd=$(pwd)
  dockerfile=$(ls Dockerfile.*)
  IFS='.' read -ra names_array <<< "$dockerfile"
    echo Building "${names_array[1]}"/"${names_array[2]}"
    if [ "$1" = "build" ]; then
      docker build . --file "$dockerfile" --tag "${names_array[1]}"/"${names_array[2]}"
    fi
    if [ "$1" = "push" ]; then
      docker push "${names_array[1]}"/"${names_array[2]}"
    fi
  ((counter++))
done
