#!/usr/bin/env bash

# shellcheck disable=SC2016
: '
  Lists the aliases, functions and bin commands this repository sets up,
  with the description from the comment directly above each one.

  Usage: dotfiles list [aliases|functions|bin] [term]

  @param  group [$1]  Optional group to show: aliases, functions or bin. Anything
                      else is treated as the search term.
  @param  term  [$2]  Optional case-insensitive search over name, description and
                      (for aliases) command
'
dotfiles-list() {
  local root="${0%/*}"
  local group=""
  local term=""

  case "$1" in
    "aliases" | "functions" | "bin") group="$1"; term="$2";;
    *)                               term="$1";;
  esac

  {
    __dotfiles-list-aliases "$root/dots/aliases.symlink"
    __dotfiles-list-functions "$root/dots/functions.symlink"
    __dotfiles-list-bin "$root/bin"
  } | awk -F '\t' -v group="$group" -v term="$term" '
    {
      if (group != "" && $1 != group) next
      if (term != "" && index(tolower($2 "\t" $3 "\t" $4), tolower(term)) == 0) next
      n++; g[n] = $1; name[n] = $2; desc[n] = $3
      if (length($2) > width) width = length($2)
    }
    END {
      if (n == 0) {
        if (term != "") printf "No matches for \"%s\"\n", term
        exit 1
      }
      split("aliases functions bin", order, " ")
      title["aliases"] = "Aliases"; title["functions"] = "Functions"; title["bin"] = "Commands (bin)"
      printed = 0
      for (o = 1; o <= 3; o++) {
        heading = 0
        for (i = 1; i <= n; i++) {
          if (g[i] != order[o]) continue
          if (!heading) {
            if (printed) print ""
            print title[order[o]]
            heading = 1; printed = 1
          }
          printf "  %-" width "s   %s\n", name[i], desc[i]
        }
      }
    }
  '
}

# Shared awk helpers: comment blocks become a one-line description made of
# their first line plus any continuation lines that start in lowercase.
__dotfiles_list_awk_lib='
  function reset() { nc = 0; inquote = 0 }
  function addcomment(line) {
    gsub(/^[ \t]+|[ \t]+$/, "", line)
    if (line == "" && nc == 0) return
    comments[++nc] = line
  }
  function description(   d, i) {
    d = ""
    for (i = 1; i <= nc; i++) {
      if (comments[i] == "") break
      if (i > 1 && comments[i] !~ /^[a-z]/) break
      d = (d == "" ? comments[i] : d " " comments[i])
    }
    return d
  }
  # Collects "# ..." lines and ": '"'"' ... '"'"'" blocks; returns 1 when the
  # line was part of a comment.
  function comment(line) {
    if (inquote) {
      if (line ~ /^[ \t]*'"'"'[ \t]*$/) inquote = 0
      else addcomment(line)
      return 1
    }
    if (line ~ /^: '"'"'/) {
      inquote = 1
      sub(/^: '"'"'/, "", line)
      addcomment(line)
      return 1
    }
    if (line ~ /^#!/) return 1
    if (line ~ /^#/) {
      sub(/^#+/, "", line)
      if (line ~ /^[ \t]*$/ && nc > 0) { comments[++nc] = ""; return 1 }
      addcomment(line)
      return 1
    }
    return 0
  }
'

# Prints "aliases<TAB>name<TAB>description<TAB>command" per alias. A comment
# only describes an alias when it sits directly above a block holding that one
# alias; comments over several aliases are section headers, so those show
# their command instead.
__dotfiles-list-aliases() {
  [[ -f "$1" ]] || return 0
  awk "$__dotfiles_list_awk_lib"'
    function flush(   i, d) {
      for (i = 1; i <= np; i++) {
        d = (np == 1 && desc != "") ? desc : cmd[i]
        printf "aliases\t%s\t%s\t%s\n", pname[i], d, cmd[i]
      }
      np = 0; desc = ""
    }
    /^alias[ \t]/ {
      line = $0
      sub(/^alias[ \t]+/, "", line)
      eq = index(line, "=")
      if (eq == 0) next
      if (np == 0) desc = description()
      np++
      pname[np] = substr(line, 1, eq - 1)
      value = substr(line, eq + 1)
      first = substr(value, 1, 1)
      if ((first == "\"" || first == "'"'"'") && substr(value, length(value), 1) == first)
        value = substr(value, 2, length(value) - 2)
      cmd[np] = value
      reset()
      next
    }
    { flush() }
    comment($0) { next }
    { reset() }
    END { flush() }
  ' "$1"
}

# Prints "functions<TAB>name<TAB>description" per top-level function.
__dotfiles-list-functions() {
  [[ -f "$1" ]] || return 0
  awk "$__dotfiles_list_awk_lib"'
    comment($0) { next }
    /^(function[ \t]+)?[A-Za-z0-9_.:-]+[ \t]*\(\)/ {
      line = $0
      sub(/^function[ \t]+/, "", line)
      sub(/[ \t]*\(\).*$/, "", line)
      printf "functions\t%s\t%s\n", line, description()
    }
    { reset() }
  ' "$1"
}

# Prints "bin<TAB>name<TAB>description" per executable, described by the
# comment block at the top of the file.
__dotfiles-list-bin() {
  [[ -d "$1" ]] || return 0
  local file
  for file in "$1"/*; do
    [[ -f "$file" && -x "$file" ]] || continue
    awk -v name="${file##*/}" "$__dotfiles_list_awk_lib"'
      comment($0) { next }
      { exit }
      END { printf "bin\t%s\t%s\n", name, description() }
    ' "$file"
  done
}
