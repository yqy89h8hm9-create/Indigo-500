#!/bin/bash

# create output folder
echo ">> create output folder..."
rm -rf ../_site
mkdir -p ../_site

# copy images to output folder
# (サブディレクトリ内の画像も考慮して構造を保ったままコピーするように修正)
echo ">> copy images to output folder..."
find . -name "*.png" -o -name "*.jpg" -o -name "*.gif" -o -name "*.svg" | xargs -I {} cp --parents -v {} ../_site/

# copy adoc to output folder
# (ここは元のままでOK。--parentsのおかげでサブディレクトリ構造が維持されます)
echo ">> copy adoc to output folder..."
find . -name "*.adoc" -type f | xargs -I {} cp --parents -v {} ../_site/

# build adoc
# (修正箇所: findを使って再帰的に検索し、まとめてビルドするように変更)
echo ">> build adoc ..."
find ../_site -name "*.adoc" -type f -print0 | xargs -0 asciidoctor -r asciidoctor-diagram -a source-highlighter=rouge -a rouge-style=monokai_sublime --backend=html5

# remove temporary adoc
# (修正箇所: サブディレクトリ内のadocも削除するように変更)
echo ">> remove temporary adoc..."
find ../_site -name "*.adoc" -type f -delete

echo ">> Done!"
echo ">> Here's converted files..."
ls -R ../_site/