#################
# TMate plugin
# @author: oddpoet@gmail.com
#
# tmate(https://tmate.io/) is a fork of tmux.
# This plugin manages socketfile for session and provides auto-completion.
#
# note: tmate doesn't support multiple-session, so it create a session per socketfile.
#------
if which tmate &> /dev/null
then
  local SOCKET_PATH=/tmp/tmate-501
  mkdir -p $SOCKET_PATH

  # socket file path
  function tm_socket() {
    echo $SOCKET_PATH/$1
  }

  # create session
  function tmnew() {
    local session=$1
    if [[ "$session" == "" ]];then
      print "usage: tmnew session_name"
      print "  (create new session)"
      return 1
    fi
    # check socketfile
    local socket_file=$(tm_socket $session)
    if [ -S $socket_file ];then
      print "sokect file already exists: $socket_file"
      return 1
    fi
    tmate -S $socket_file new-session -d
    tmate -S $socket_file wait tmate-ready
    tmate -S $socket_file rename-session -t 0 $session
    print "created tmux session : $session"
    print "you could attach this session like blow :"
    print " tma $session"
    print
  }

  # kill session
  function tmkill() {
    local session=$1
    if [[ "$session" == "" ]];then
      print "usage: tmkill session_name"
      print "  (kill given session)"
      return 1
    fi

    local socket_file=$(tm_socket $session)
    if [ ! -S $socket_file ];then
      print "session NOT exists : $session"
      print
      return 1
    fi
    tmate -S $socket_file kill-server
    print "killed tmux session : $session"
  }

  # list sessions
  function tmls() {
    ls $SOCKET_PATH | sed 's/.sock$//g'
  }

  # attach session
  function tma() {
    local session=$1
    if [[ "$session" == "" ]];then
      print "usage: tma session_name"
      print "  (attach given session)"
      return 1
    fi

    local socket_file=$(tm_socket $session)
    if [ ! -S $socket_file ];then
      print "session NOT exists : $session"
      print
      return 1
    fi
    # get actual session name. (session name could be changed by user.)
    print "attaching tmux session : $session"
    local session=`tmate -S $socket_file ls | awk -F : '{print $1}'`
    tmate -S $socket_file a -t $session
  }

  # print session info to share
  function tmshare() {
    local session=$1
    if [[ "$session" != "" ]];then
      local socket_file=$(tm_socket $session)
      if [ ! -S $socket_file ];then
        print "session NOT exists : $session"
        print
        return 1
      fi
      print "tmux session: $1"
      print "* read-only"
      tmate -S $socket_file display -p ' #{tmate_ssh_ro}'
      tmate -S $socket_file display -p ' #{tmate_web_ro}'
      print "* read-write"
      tmate -S $socket_file display -p ' #{tmate_ssh}'
      tmate -S $socket_file display -p ' #{tmate_web}'
    elif [[ "$TMUX" != "" ]]; then
      print "current shell on tmux session: "
      print "* read-only"
      tmate display -p ' #{tmate_ssh_ro}'
      tmate display -p ' #{tmate_web_ro}'
      print "* read-write"
      tmate display -p ' #{tmate_ssh}'
      tmate display -p ' #{tmate_web}'
    else
      print "usage: tmshare session_name"
      print "  (print session info to share)"
    fi

  }

  function _tm_list_session() {
    _arguments "1: :($(tmls))"
  }

  compdef _tm_list_session tma
  compdef _tm_list_session tmkill
  compdef _tm_list_session tmshare

  # alias
else
  print "zsh tmate plugin: tmate not found. Please install tmate before using this plugin."
fi
