#!/usr/bin/env bash

: '
  Provides confirmation and processing state reporting on top of the provided task

  @param  title [$1]  The title of the task to report
  @param  task  [$2]  The task to execute under confirmation and reporting capabilities
'
configuration-report() {
  local __progress="  ⏳ In Progress...      "
  local __skipped_="  ⏭ Skipped             "
  local __is__done="  ✅ Done                "
  local __is_error="  ❌ Something went wrong"
  local __clean_pg="                         "

  echo ""
  echo -ne "$1 \n"

  if ! confirm "Proceed?"; then
    echo $__skipped_
    return 0
  fi

  if $2; then
    echo $__is__done
  else
    echo $__is_error
  fi
}
