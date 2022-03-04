cdswitch(){
  builtin cd "$@";
  cdir=$PWD;
  if [ -f "$cdir/.tgswitchrc" ]; then
    tgswitch
  fi
  if [ -f "$cdir/.terragrunt-version" ]; then
    tgswitch
  fi
  if [ -e "$cdir/.tfswitchrc" ]; then
      tfswitch
  fi
  if [ -e "$cdir/.terraform-version" ]; then
        tfswitch
  fi
}
alias cd='cdswitch'