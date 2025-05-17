IFS=$'\n' read -d "" -ra file_data < .gitignore
for element in "${file_data[@]}"; do

    if [[ "$element" != *"#"* ]]; then
      if test -f $element; then
        echo "Removing $element"
        rm -rf $element
      fi
      if test -d $element; then
        echo "Removing $element"
        rm -rf $element
      fi
    fi
done
