#!/usr/bin/env bash
set -eu

git_env=$(git rev-parse --local-env-vars)
unset $git_env

source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
temp=$(mktemp -d)
trap 'rm -rf -- "$temp"' EXIT
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null

git init -q -b main "$temp/produkt"
printf 'Fixture\n' > "$temp/produkt/datei"
git -C "$temp/produkt" add datei
git -C "$temp/produkt" -c user.name=Fixture -c user.email=fixture@example.invalid \
    commit -qm Fixture
mkdir "$temp/lokale Remotes"
git clone -q --bare "$temp/produkt" "$temp/lokale Remotes/produkt.git"

mkdir "$temp/workspace"
cd -P -- "$temp/workspace"
cp -R "$source_dir"/{workspace,.gitignore,README.md,AGENTS.md,LICENSE,.agents,tests} .
git init -q
printf '  # Lokale Remotes\r\n  \r\n  %s  \r\n' "$temp/lokale Remotes/produkt.git" > repositories.txt
GIT_WORK_TREE="$temp/anderer-worktree" ./workspace clone
[[ ! -e $temp/anderer-worktree ]]
[[ $(git -C produkt rev-parse --show-toplevel) == "$PWD/produkt" ]]
[[ $(cat produkt/datei) == Fixture ]]

printf 'Lokale Arbeit\n' > produkt/datei
./workspace clone
[[ $(cat produkt/datei) == 'Lokale Arbeit' ]]

printf '%s\n' "$temp/fehlt.git" >> repositories.txt
output=$(./workspace status)
grep -Fx 'produkt: vorhanden' <<< "$output"
grep -E '^## main([.][.][.]|$)' <<< "$output"
grep -Fx ' M datei' <<< "$output"
grep -Fx 'fehlt: fehlt' <<< "$output"

# Git könnte die Stat-Daten der wiederhergestellten Datei im Index auffrischen.
printf 'Fixture\n' > produkt/datei
touch -t 200001010000 produkt/.git/index
./workspace status >/dev/null
[[ ! produkt/.git/index -nt produkt/datei ]]

mkdir fehlt
printf 'Fremde Datei\n' > fehlt/datei
if output=$(./workspace clone 2>&1); then
    exit 1
fi
grep -F 'fehlt: Zielpfad ist belegt' <<< "$output"
[[ $(cat fehlt/datei) == 'Fremde Datei' ]]

git check-ignore -q produkt/datei
git add .
[[ -z $(git ls-files -- produkt fehlt) ]]
git ls-files --error-unmatch .gitignore README.md AGENTS.md LICENSE workspace repositories.txt \
    .agents/skills/{review-change,simplify-change}/SKILL.md tests/test-workspace.sh >/dev/null
