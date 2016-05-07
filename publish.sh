jekyll build &&
rm -rf tmpdir &&
mkdir tmpdir &&
rsync -av --exclude='*.sh' --exclude='Vagrantfile' _site/ tmpdir/ &&
cd tmpdir &&
git init &&
git add . &&
git commit -m \"Site Updated\" &&
git remote add origin git@github.com:notamedia/opensource.notamedia.ru.git &&
git push origin master --force &&
cd .. &&
rm -rf tmpdi