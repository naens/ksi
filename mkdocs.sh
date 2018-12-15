robodoc --src . --doc ./docs --html --multidoc --nodesc \
    --sections --tell --toc --index --css robodoc.css

for f in docs/*.html
do
    sed -i -e 's/toc_index.html/index.html/' "$f"
done

mv docs/toc_index.html docs/index.html
