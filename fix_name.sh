#!/usr/bin/env bash
#=============================================================================#
# It appears that github.io doesn't recognize directory beginning with "_", 
# the underscore character. 
#-----------------------------------------------------------------------------#
# Repalce string "_static" with "static"
# Repalce string "_sources" with "sources"
# Repalce string "_images" with "images"
#=============================================================================#
#http://stackoverflow.com/questions/14505047/bash-loop-through-all-the-files-with-a-specific-extension
for file in "./build/html/*.html"; do
    #echo $file
    sed -i 's/_static\//static\//' $file
    sed -i 's/_sources\//sources\//' $file
    sed -i 's/_modules\//modules\//' $file
done

DIRECTORY="./build/html/generated"
if [ -d "$DIRECTORY" ]; then
    for file in "${DIRECTORY}/*.html"; do
        #echo $file
        sed -i 's/_static\//static\//' $file
        sed -i 's/_sources\//sources\//' $file
        sed -i 's/_modules\//modules\//' $file
    done
else
    echo "NO DIR. DO NOTHING"
fi

DIRECTORY="./build/html/generated/generated"
if [ -d "$DIRECTORY" ]; then
    for file in "${DIRECTORY}/*.html"; do
        #echo $file
        sed -i 's/_static\//static\//' $file
        sed -i 's/_sources\//sources\//' $file
        sed -i 's/_modules\//modules\//' $file
    done
else
    echo "NO DIR. DO NOTHING"
fi


# rename directories with underscore
build_dir='./build/html'
mv ${build_dir}/_sources ${build_dir}/sources
mv ${build_dir}/_static ${build_dir}/static
mv ${build_dir}/_modules ${build_dir}/modules

